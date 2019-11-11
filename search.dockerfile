#!/usr/bin/env -S docker build --compress -t pvtmert/elk:search -f

FROM centos:6

FROM debian
RUN apt update
RUN apt install -y curl dnsutils

ARG VERSION=7.4.2
WORKDIR /data
RUN export FILE="elasticsearch-${VERSION}-$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m).tar.gz"; \
	curl -#L "https://artifacts.elastic.co/downloads/elasticsearch/${FILE}" \
	| tar --strip=1 -oxz

EXPOSE 9200 9300
ARG USER=elastic
RUN useradd -m "${USER}"
RUN mkdir -p data
RUN chown -R "${USER}:users" config data logs
ENV USER "${USER}"
CMD runuser -l "${USER}" -c "$PWD/bin/elasticsearch -vp /tmp/pid"
