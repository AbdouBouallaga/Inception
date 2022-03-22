FROM debian:buster
RUN apt update
RUN apt install vsftpd -y
COPY ./conf/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
RUN chown root:root /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD vsftpd