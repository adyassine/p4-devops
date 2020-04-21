FROM debian:latest
MAINTAINER Adil YASSINE <ad.yassine@gmail.com>

RUN \
  apt update && \
  apt install -y --no-install-recommends wget ca-certificates nginx openssh-server git && rm -rf /var/lib/apt/lists/*

RUN pip install pelican[Markdown]
