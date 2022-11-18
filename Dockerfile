FROM alpine:3.15
RUN apk update && \
    apk add --no-cache mpd mpc pulseaudio shadow

RUN usermod -u 1000 mpd

RUN mkdir -p /var/lib/mpd/data && \
    chown -R mpd:audio /var/lib/mpd && \
    mkdir -p /run/mpd && \
    chown -R mpd:audio /run/mpd && \
    touch /var/lib/mpd/state && \
    chown -R mpd:audio /var/lib/mpd/state && \
    touch /var/lib/mpd/sticker.sql && \
    chown -R mpd:audio /var/lib/mpd/sticker.sql && \
    touch /var/log/mpd/mpd.log && \
    chown -R mpd:audio /var/log/mpd/mpd.log

VOLUME ["/var/lib/mpd"]
COPY pulse-client.conf /etc/pulse/client.conf

EXPOSE 6600 8800
CMD [ "mpd", "--stdout", "--no-daemon", "/etc/mpd.conf" ]
