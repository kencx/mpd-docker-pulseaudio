FROM alpine:3.15

RUN apk update && \
    apk add --no-cache mpd mpc pulseaudio shadow

RUN usermod -u 1000 mpd; \
    mkdir -p /var/lib/mpd/data; \
    touch /var/lib/mpd/state /var/lib/mpd/sticker.sql; \
    chown -R mpd:audio /var/lib/mpd;

VOLUME ["/var/lib/mpd"]
COPY pulse-client.conf /etc/pulse/client.conf

EXPOSE 6600 8800
CMD [ "mpd", "--stdout", "--no-daemon", "/etc/mpd.conf" ]
