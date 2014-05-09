require 'proceso/version'
require 'rack'

module Proceso
  class Middleware

    SUBSCRIPTION = 'proceso.usage'

    class << self

      def start_instrument!
        logger.info "[Proceso #{Proceso::VERSION}] Proceso Middleware is activated. (#{Rails.env.to_s} mode)"
        subscribe do |name, start, finish, id, payload|
          mem_used    = (payload[:mem_used].to_f / 1024.0).round(1)
          cpu_used    = payload[:cpu_used].to_f.round(1)
          path        = payload[:request].path_info
          resp_time   = payload[:resp_time]
          logger.debug "[PROCESO] MEM: #{mem_used}KB\tCPU: #{cpu_used}\tRESP: #{resp_time}ms\tPATH: #{path}"
        end
      end

      def subscribe(&blk)
        ActiveSupport::Notifications.subscribe(SUBSCRIPTION, &blk)
      end

      def logger
        @logger ||= begin
          Rails.configuration.logger || ActiveSupport::Logger.new(STDOUT)
        end
      end

    end

    attr_reader :app, :pid, :notifier, :config

    def initialize(app, options = {})
      @app       = app
      @notifier  = ActiveSupport::Notifications
      @pid       = Process.pid
      @config    = ActiveSupport::InheritableOptions.new(options[:config])
    end

    def call(env)
      return @app.call(env) if path_excluded?(env["PATH_INFO"])
      capture_process_usage(env) do
        @app.call(env)
      end
    end

    def capture_process_usage(env)
      request = Rack::Request.new(env)
      mem_1, cpu_1 = build_process_payload
      response = yield
      mem_2, cpu_2 = build_process_payload
      process_payload = calculate_process_usage(request, mem_1, mem_2, cpu_1, cpu_2)
      notifier.instrument(SUBSCRIPTION, process_payload)
      response
    end

    def build_process_payload
      mem   = process.mem_size
      cpu   = process.user_cpu_times
      [mem, cpu]
    end

    def calculate_process_usage(req, m1, m2, c1, c2)
      mem_used  = m2 - m1
      cpu_used  = c2 - c2
      {
        pid:       process.pid,
        mem_used:  mem_used,
        cpu_used:  cpu_used,
        request:   req
      }
    end

    def process
      @process ||= Proceso::PID.new(pid)
    end

    def exclusions
      config.exclusions || []
    end

    def path_excluded?(path)
      exclusions.any? {|e| path =~ e }
    end

  end
end
