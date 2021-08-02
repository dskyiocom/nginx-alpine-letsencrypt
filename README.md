[![Build Status](https://travis-ci.com/dskyiocom/nginx-alpine-letsencrypt.svg?branch=main)](https://travis-ci.com/dskyiocom/nginx-alpine-letsencrypt)

# Summary

Obtains configured certificates using Let's Encrypt

# Source code

https://github.com/dskyiocom/nginx-alpine-letsencrypt

# Tags

- `latest`

# NGINX configuration

Upon start the NGINX configuration is scanned for `ssl_certificate` directives pointing to `/etc/letsencrypt/live/*/fullchain.pem` files.

`certbot` is executed for every non existent certificate.

Sample config:
```
server {
  listen [::]:443 http2 ssl;
  listen 443 http2 ssl;
  server_name example.com;
  ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
  root /usr/share/nginx/html;
}
```

# How to use this image

You need to agree to the ACME server's Subscriber Agreement by setting `AGREE_TOS` to `true`.

Passing an account notification `EMAIL` is optional.

```console
mkdir certs
docker run -e AGREE_TOS=true -e EMAIL=le-notify@example.com -p 80:80 -p 443:443 -v "$PWD/certs:/etc/letsencrypt" -v "$PWD/nginx.conf:/etc/nginx/nginx.conf" dskyiocom/nginx-alpine-letsencrypt
```

## Sample compose file

```yaml
---
version: '3.8'
services:
  nginx-alpine-letsencrypt:
    environment:
      AGREE_TOS: 'true'
      EMAIL: le-notify@example.com
    image: dskyiocom/nginx-alpine-letsencrypt
    ports:
      - 80:80
      - 443:443
    volumes:
      - ./certs:/etc/letsencrypt
      - ./nginx.conf:/etc/nginx/nginx.conf
```

# Certificate renewal

Using https://hub.docker.com/repository/docker/dskyiocom/renew-letsencrypt automatic renewals can be setup
