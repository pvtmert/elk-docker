#!/usr/bin/env -S docker build --compress -t pvtmert/elk:kibana -f

#FROM centos:6

FROM debian
RUN apt update
RUN apt install -y curl

ARG USER=kibana
RUN useradd -g users -m "${USER}"
USER "${USER}"
WORKDIR /data

ARG VERSION=7.4.2
RUN export FILE="kibana-${VERSION}-$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m).tar.gz"; \
	curl -#L "https://artifacts.elastic.co/downloads/kibana/${FILE}" \
	| tar --strip=1 -oxz

#RUN mkdir -p data
#RUN chown -R "${USER}:users" config data optimize

#ENV USER "${USER}"
#CMD runuser -l "${USER}" -c "$PWD/bin/kibana -vp /tmp/pid"

EXPOSE 5601
CMD ./bin/kibana serve --verbose
