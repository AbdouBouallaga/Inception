FROM debian:buster
RUN apt update
RUN apt install -y redis-server
RUN ulimit -c unlimited
COPY ./conf/redis.conf /etc/redis/redis.conf
# CMD redis_server /etc/redis/redis.conf
CMD redis-server /etc/redis/redis.conf