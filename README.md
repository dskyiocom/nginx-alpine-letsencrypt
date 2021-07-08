# Summary

Obtains configured certificates using Let's Encrypt

# Source code

https://github.com/dskyiocom/nginx-alpine-letsencrypt

# Tags

- `latest`

# NGINX configuration

Upon start the NGINX configuration is scanned for `ssl_certificate` directives pointing to `/etc/letsencrypt/live/*/fullchain.pem` files.

`certbot` is executed for every non existent certificate

Sample config:
```
ssl_certificate /etc/letsencrypt/live/git.dskyio.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/git.dskyio.com/privkey.pem;
```

# How to use this image

You need to agree to the ACME server's Subscriber Agreement by setting `ACCEPT_TOS` to `true`.

Passing account notification `EMAIL` is optional.

```console
mkdir certs
docker run -e ACCEPT_TOS=true -e EMAIL=letsencrypt-notify@example.com -v "$PWD/certs:/etc/letsencrypt" -v "$PWD/nginx.conf:/etc/nginx/nginx.conf" nginx-alpine-letsencrypt
```
