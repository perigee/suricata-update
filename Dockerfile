FROM ubuntu:noble


RUN apt -y update && apt -y install software-properties-common python3-launchpadlib && \
    add-apt-repository -y ppa:oisf/suricata-stable && \
    apt -y update && apt -y install suricata=1:7.0.10-0ubuntu0

ADD update.yaml /etc/suricata/update.yaml


RUN useradd -Mrs /bin/bash suricata && chown -R suricata:suricata /var/log/suricata && \
    mkdir -p /var/lib/suricata && \
    chown -R suricata:suricata /var/lib/suricata && \
    chown -R suricata:suricata /etc/suricata

USER suricata

