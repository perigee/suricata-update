FROM debian:12.10-slim AS build


COPY suricata-7.0.10.tar.gz /tmp/suricata-7.0.10.tar.gz

RUN apt update && apt -y install autoconf automake build-essential cargo \
    cbindgen libjansson-dev libpcap-dev libpcre2-dev libtool \
    libyaml-dev make pkg-config rustc zlib1g-dev && \
    tar xzvf /tmp/suricata-7.0.10.tar.gz -C /tmp

WORKDIR /tmp/suricata-7.0.10
RUN ./configure --disable-gccmarch-native --prefix=/usr/ --sysconfdir=/etc --localstatedir=/var && \
    make install install-conf DESTDIR=/fakeroot

FROM node:24.0.1-slim AS runner

RUN apt update && apt -y install cargo \
    libjansson-dev libpcap-dev libpcre2-dev libtool libyaml-dev zlib1g-dev


COPY --from=build /fakeroot/etc  /etc
COPY --from=build /fakeroot/usr  /usr
COPY --from=build /fakeroot/var/lib/suricata  /var/lib/suricata
COPY --from=build /fakeroot/var/log/suricata  /var/log/suricata
COPY --from=build /fakeroot/var/run/suricata  /var/run/suricata
#COPY --from=build /fakeroot  /fakeroot
COPY update.yaml /etc/suricata/update.yaml

# clean up
RUN /usr/bin/suricata-update update-sources
RUN /usr/bin/suricata-update --no-reload

RUN rm -rf /var/lib/apt/lists/*