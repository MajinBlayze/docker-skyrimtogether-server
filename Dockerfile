FROM ich777/winehq-baseimage

LABEL maintainer="brandonreno@gmail.com"

RUN dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get -y install lib32gcc1 screen xvfb && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/serverdata"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USER="steam"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]