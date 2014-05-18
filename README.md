Proceso Middleware
---

A Rails middleware to print the memory and cpu usage per HTTP request.

```
Started GET "/" for 127.0.0.1 at 2014-05-18 02:31:23 -0500
Processing by HomeController#index as HTML
  User Load (0.4ms)  SELECT  "users".* FROM "users"  WHERE "users"."remember_token" IS NULL  ORDER BY "users"."id" ASC LIMIT
  ...
  Completed 200 OK in 12ms (Views: 11.4ms | ActiveRecord: 0.5ms)
[PROCESO] MEM: 12.0KB   CPU: 0.0        PATH: /
```


See [Proceso](bry4n/proceso) for details.

### Setup

1) Add this to your project's Gemfile

```ruby
gem 'proceso-rails', group: :development
```

2) Then start rails server!

```bash
$ rails server
```

### Contributing

If you would like to contribute, please:

* Fork this project
* Write tests if code is involved.
* Use named branch
* Submit Pull Request

### License

Proceso Rails is licensed under the MIT License
