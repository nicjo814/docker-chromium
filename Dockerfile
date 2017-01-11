FROM nicjo814/docker-baseimage-xenial-x

ENV APTLIST="chromium-browser"

RUN \
# install packages
apt-get update -q && \
apt-get install \
$APTLIST -qy && \

# cleanup
cd / && \
apt-get autoremove -y && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# add some files
COPY root/ /
