# Ruby WebSockets Chat Demo

## Setup

You'll need Postgres and Redis, which are available with a brew install.


To install all the dependencies, run:
```
bundle install
```


Next the app requires some env vars for configuration. A sample `.env.sample` is provided for running the app locally. You can copy `.env.sample` to `.env` which foreman will pick up.

Using foreman we can boot the application.

```
$ foreman start
```

You can now visit <http://localhost:5000> to see the application.
