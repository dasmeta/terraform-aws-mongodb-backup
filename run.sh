#!/bin/bash

env > /etc/environment

PORT=${MONGODB_PORT:-27017}
HOST=${MONGODB_HOST:-""}


MONGODB_USER=${MONGO_INITDB_ROOT_USERNAME:-""}
MONGODB_PASS=${MONGO_INITDB_ROOT_PASSWORD:-""}

#BACKUP_CMD="mongodump --out /backup/"'${BACKUP_NAME}'" --gzip --host ${MONGODB_HOST} --port ${MONGODB_PORT} ${USER_STR}${PASS_STR}${DB_STR} ${EXTRA_OPTS}"
BACKUP_CMD="mongodump --out /backup/"'${BACKUP_NAME}'" --host ${HOST} --port ${PORT} --username ${MONGODB_USER} --password ${MONGODB_PASS} --authenticationDatabase admin"

rm -f /backup.sh
cat <<EOF >> /backup.sh
#!/bin/bash
MAX_BACKUPS=${MAX_BACKUPS:-"30"}
BACKUP_NAME=\$(date +\%Y.\%m.\%d.\%H\%M\%S)

echo "=> Backup started"
if ${BACKUP_CMD} ; then
    echo "   Backup succeeded"
else
    echo "   Backup failed"
    rm -rf /backup/\${BACKUP_NAME}
fi

if [ -n "\${MAX_BACKUPS}" ]; then
    while [ \$(ls /backup -N1 | wc -l) -gt \${MAX_BACKUPS} ];
    do
        BACKUP_TO_BE_DELETED=\$(ls /backup -N1 | sort | head -n 1)
        echo "   Deleting backup \${BACKUP_TO_BE_DELETED}"
        rm -rf /backup/\${BACKUP_TO_BE_DELETED}
    done
fi

if [ -n "\${S3_BUCKET}" ]; then
    echo "=> Starting Migration process..."
    source /migrate_backup_aws.sh
else
    echo "=> S3_BUCKET variable was not set, skipping migration"
    echo "=> Database backup was saved in /backup/\${BACKUP_NAME}"
fi
EOF

chmod +x /backup.sh

chmod +x /restore.sh

chmod +x /migrate_backup_aws.sh

touch /mongo_backup.log
tail -F /mongo_backup.log &

if [[ "${INIT_BACKUP}" = true ]]; then
    echo "=> Creating a backup on startup"
    /backup.sh
fi

if [[ "${INIT_RESTORE}" = true ]]; then
    echo "=> Restoring the latest backup on startup"
    /restore.sh
fi

echo "${CRON_TIME} . /etc/environment; /backup.sh >> /mongo_backup.log 2>&1" > /crontab.conf
#echo "${MIGRATE_CRON_TIME} /migrate_backup_aws.sh >> /mongo_backup.log 2>&1" >> /crontab.conf
crontab  /crontab.conf
echo "=> Running cron job"
exec cron -f
