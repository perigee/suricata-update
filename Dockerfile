FROM ubuntu:noble


RUN apt -y update && apt -y install software-properties-common python3-launchpadlib && \
    add-apt-repository -y ppa:oisf/suricata-stable && \
    apt -y update && apt -y install suricata=1:7.0.10-0ubuntu0

ADD update.yaml /etc/suricata/update.yaml
ADD entrypoint.sh /entrypoint.sh


RUN useradd -Mrs /bin/bash suricata && \
    mkdir -p /var/lib/suricata && \
    mkdir -p /var/run/suricata && \    
    chown -R suricata:suricata /var/log/suricata && \
    chown -R suricata:suricata /var/lib/suricata && \
    chown -R suricata:suricata /var/run/suricata && \    
    chown -R suricata:suricata /etc/suricata && \
    chown -R suricata:suricata /entrypoint.sh && \
    chmod +x /entrypoint.sh

#USER suricata
ENTRYPOINT ["/entrypoint.sh"]
