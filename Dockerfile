FROM nicjo814/docker-baseimage-xenial-x

ENV APTLIST="chromium-browser chromium-browser-l10n msttcorefonts"

RUN \
# install packages
apt-get update -q && \
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | debconf-set-selections && \
apt-get install \
$APTLIST -qy && \

# cleanup
cd / && \
apt-get autoremove -y && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# add some files
COPY root/ /
