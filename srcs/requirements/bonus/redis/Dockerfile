FROM debian:buster
RUN apt update
RUN apt install -y redis-server redis-tools
COPY ./conf/redis.conf /etc/redis/redis.conf
CMD redis_server /etc/redis/redis.conf