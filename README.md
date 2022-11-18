## mpd & PulseAudio in Docker

This image runs mpd & PulseAudio in Docker. It utilizes a standard mpd config with
pulseaudio output. Refer to `docker-compose.yml` for an example on how to run the image.

Note that the image requires `SYS_NICE` capabilities to run.

### PulseAudio in Docker
The resultant container does not run its own PulseAudio server. Instead, mpd connects to
the host's PulseAudio server and outputs sound to the host directly. This is done by
exposing the host's PulseAudio socket `/run/user/$(id -u)/pulse` to the container and
inject the environment variable `PULSE_SERVER=/run/user/$(id -u)/pulse/native`.

>The container must be running with the **same UID** as the host user for `mpd` to connect to the
>socket.

Finally, we ensure that PulseAudio is not started within the container with a custom
`pulse-client.conf`. It prevents the use of shared memory by disabling `shm` which is
known to cause errors.

## References
- [x11docker - Container sound](https://github.com/mviereck/x11docker/wiki/Container-sound:-ALSA-or-Pulseaudio)
- [docker-pulseaudio-example](https://github.com/TheBiggerGuy/docker-pulseaudio-example)
- [Passing audio into docker](https://comp0016-team-24.github.io/dev/problem-solving/2020/10/30/passing-audio-into-docker.html)
