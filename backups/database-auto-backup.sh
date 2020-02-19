#!/bin/bash

BACKUP_DIRECTORY="$(dirname $(readlink -f $0))/databases"
FILES_IN_BACKUP_DIRECTORY="ls -1q $BACKUP_DIRECTORY | wc -l"
MAX_FILES_IN_BACKUP_DIRECTORY=
DATABASE_NAMES=()

echo "Files in backup directory: $(eval "$FILES_IN_BACKUP_DIRECTORY")/${MAX_FILES_IN_BACKUP_DIRECTORY}"

while [ $(eval "$FILES_IN_BACKUP_DIRECTORY") -gt $MAX_FILES_IN_BACKUP_DIRECTORY ]
do
    echo "Max files in backup directory reached removing oldest file."
    rm "${BACKUP_DIRECTORY}/$(ls -t ${BACKUP_DIRECTORY} | tail -1)"
    echo "Files in backup directory: $(eval "$FILES_IN_BACKUP_DIRECTORY")/${MAX_FILES_IN_BACKUP_DIRECTORY}"
done

NOW=$(date +%Y-%m-%d.%H:%M:%S)

for i in "${DATABASE_NAMES[@]}"
do
   echo "Creating database dump for database: $i"
   mysqldump --defaults-extra-file="${BACKUP_DIRECTORY}/../config.cnf"  $i > ${BACKUP_DIRECTORY}/${i}_${NOW}.sql
   echo "Files in backup directory: $(eval "$FILES_IN_BACKUP_DIRECTORY")/${MAX_FILES_IN_BACKUP_DIRECTORY}"
done
