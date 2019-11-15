#!/usr/bin/env -S docker build --compress -t pvtmert/elk:kibana -f

#FROM centos:6

FROM debian:latest
RUN apt update
RUN apt install -y curl

ARG USER=kibana
RUN useradd -g users -m "${USER}"
USER "${USER}"
WORKDIR "/home/${USER}"

ARG VERSION=7.4.2
RUN export FILE="kibana-${VERSION}-$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m).tar.gz"; \
	curl -#L "https://artifacts.elastic.co/downloads/kibana/${FILE}" \
	| tar --strip=1 -xz

EXPOSE 5601
CMD ./bin/kibana serve --verbose
