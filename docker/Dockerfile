FROM bitnami/minideb:buster-amd64
LABEL maintainer="Razmik Avetikyan <razmik.avetikyan@dasmeta.com>"

# install container packages
RUN apt-get update && apt-get install -y zip unzip cron python3-pip groff curl wget gnupg gnupg2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Install mongodb
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt-get update
RUN apt-get install -y mongodb-org

RUN mkdir -p /backup /restore /config && chmod 0777 /config

COPY migrate_backup_aws.sh restore.sh run.sh tmp_mongo_user.js /

RUN chmod +x /run.sh

# cleanup
RUN apt-get clean autoclean
RUN apt-get autoremove --yes
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/

ENTRYPOINT ["/bin/bash", "/run.sh"]
