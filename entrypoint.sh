#!/bin/sh

[ "$AGREE_TOS" = true ] || exit 1
[ "$(id -u)" != 0 ] && exec nginx -g 'daemon off;'

while :; do
  match="$(nginx -T 2>&1 | egrep -o 'cannot load certificate "/etc/letsencrypt/live/[^/]*/fullchain.pem"' | uniq)"
  [ -z "$match" ] && break
  dir="$(dirname "$(echo "$match" | awk '{print $4}' | cut -d '"' -f 2)")"
  mkdir -p "$dir"
  ln -s /work/fullchain.pem "$dir/fullchain.pem"
  ln -s /work/privkey.pem "$dir/privkey.pem"
done

for dir in /etc/letsencrypt/live/*/; do
  domain="$(basename "$dir")"
  rm -r "$dir"
  if [ -n "$EMAIL" ]; then
    certbot certonly --agree-tos -m "$EMAIL" -n --standalone -d "$domain"
  else
    certbot certonly --agree-tos -n --standalone -d "$domain"
  fi
done

exec su nginx "$0"
