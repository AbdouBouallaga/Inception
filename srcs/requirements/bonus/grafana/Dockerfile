FROM debian:buster
RUN apt update && apt install -y wget
RUN wget https://github.com/prometheus/prometheus/releases/download/v2.34.0/prometheus-2.34.0.linux-amd64.tar.gz
RUN tar -xvf prometheus-2.34.0.linux-amd64.tar.gz
RUN mv prometheus-2.34.0.linux-amd64/ /prometheus
RUN rm -rf prometheus-2.34.0.linux-amd64.tar.gz
RUN wget https://dl.grafana.com/enterprise/release/grafana-enterprise-8.4.4.linux-amd64.tar.gz
RUN tar -zxvf grafana-enterprise-8.4.4.linux-amd64.tar.gz
RUN mv grafana-8.4.4/bin/grafana-server /usr/bin/grafana-server
COPY ./conf/prometheus.yml /prometheus/prometheus.yml
# CMD grafana-server --homepath=/grafana 
CMD /prometheus/prometheus --config.file="/prometheus/prometheus.yml" & grafana-server --homepath=/grafana && fg