FROM ubuntu:latest

# Set environment variables for build and entrypoint
ENV ECO_VERSION="0.9.2.4-beta" \
    ECO_SERVER_FILES="/opt/eco" \
    ECO_SERVER_USER="eco" \
    ECO_SERVER_GROUP="eco"

# Add user and group for the service to run under
RUN groupadd -r ${ECO_SERVER_GROUP} && \
    useradd -r -g ${ECO_SERVER_GROUP} ${ECO_SERVER_USER} 

# Install all needed packages
RUN apt-get update && \
    apt-get install -y \
      dirmngr \
      gnupg \
      apt-transport-https \
      ca-certificates \
      software-properties-common && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    apt-add-repository 'deb https://download.mono-project.com/repo/ubuntu stable-focal main' && \
    apt-get install -y \
      mono-complete \
      wget \
      unzip && \
    rm -r /var/lib/apt/lists/*

# Download eco server
RUN mkdir -p ${ECO_SERVER_FILES} && \
    cd ${ECO_SERVER_FILES} && \
    wget https://play.eco/s3/eco-releases/EcoServerLinux_v${ECO_VERSION}.zip && \
    unzip EcoServerLinux_v${ECO_VERSION}.zip && \
    rm EcoServerLinux_v${ECO_VERSION}.zip

# Create folders and move files
RUN chown -R ${ECO_SERVER_USER}:${ECO_SERVER_USER} ${ECO_SERVER_FILES} && \
    chmod +x ${ECO_SERVER_FILES}/EcoServer && \
    mv ${ECO_SERVER_FILES}/Configs ${ECO_SERVER_FILES}/ConfigTemplates

# Expose ports
EXPOSE 3000 
EXPOSE 3001 

# Create volumes 
VOLUME ${ECO_SERVER_FILES}/Configs
VOLUME ${ECO_SERVER_FILES}/Storage

WORKDIR ${ECO_SERVER_FILES}
ADD ./start.sh .
RUN chmod 755 ./start.sh && \
    chown ${ECO_SERVER_USER}:${ECO_SERVER_USER} ./start.sh
ENTRYPOINT ["./start.sh"]