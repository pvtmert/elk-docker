#!/usr/bin/env -S docker build --compress -t pvtmert/elk:search -f

#FROM centos:6

FROM debian
RUN apt update
RUN apt install -y curl

ARG USER=elastic
RUN useradd -g users -m "${USER}"
USER "${USER}"
WORKDIR "/home/${USER}"

ARG VERSION=7.4.2
RUN export FILE="elasticsearch-${VERSION}-$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m).tar.gz"; \
	curl -#L "https://artifacts.elastic.co/downloads/elasticsearch/${FILE}" \
	| tar --strip=1 -xz

EXPOSE 9200 9300
CMD ./bin/elasticsearch -vp /tmp/pid
