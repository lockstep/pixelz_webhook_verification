# Pixelz Webhook Verification

This repository contains two implementation of verify Webhook process with two languages includes php(follow pixelz documentaion) and ruby.

### How to run

For php, I use apache webserver and see error log at /private/var/log/apache2/error_lo

For ruby, I use sinatra. The way to run is

```sh
ruby verify_webhook.rb
```

I also use [ngrok](https://ngrok.com/) for expose a local server behind a NAT.
