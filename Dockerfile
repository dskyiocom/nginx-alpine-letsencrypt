FROM nginx:alpine
COPY entrypoint.sh fullchain.pem privkey.pem /work/
ENTRYPOINT sh entrypoint.sh
EXPOSE 80
RUN apk add certbot
WORKDIR /work
