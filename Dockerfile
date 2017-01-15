FROM nicjo814/docker-baseimage-xenial-x

# Environment settings
ENV HOME="/config"
ENV APTLIST=" \
	chromium-browser \
	chromium-browser-l10n \
	msttcorefonts"

# install packages
RUN \
 apt-get update -q && \
	echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
	echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | debconf-set-selections && \
	apt-get install \
	$APTLIST -qy && \

# change shell to bash for user abc
 usermod -s /bin/bash abc && \

# cleanup
 cd / && \
 apt-get autoremove -y && \
 apt-get clean -y && \
 rm -rf \
 	/var/lib/apt/lists/* \
	/var/tmp/* \
	/tmp/*

# add some files
COPY root/ /

# ports and volumes
VOLUME /config