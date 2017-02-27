#!/bin/bash

BACKUP_DISK="/dev/backup-disk"
BACKUP_KEY="/dev/backup-key"

REPOSITORY="/media/YOUR_USERNAME/YOUR_BACKUP_DRIVE_UUID_HERE/borg"
KEYDIR="/media/YOUR_USERNAME/YOUR_KEY_DRIVE_UUID_HERE"
PASSPHRASE="YOUR_PASSWORD_HERE"
COMPRESSION="zlib,6"
ARCHIVE="{now}"
TARGETS+="YOUR/TARGETS/TO/BACKUP/HERE "
TARGETS+="/AND/HERE "
TARGETS+="ETC "

if [ ! -b $BACKUP_DISK ] || [ ! -b $BACKUP_KEY ]
then
  exit 1
fi

# Repo created with
# borg init --encryption=keyfile /media/luka/75824427-9211-4aca-90e1-f739c91e1afc/borg

export BORG_KEYS_DIR=$KEYDIR
export BORG_PASSPHRASE=$PASSPHRASE

notify-send Backup "Starting."
borg create --verbose --stats --progress --compression=$COMPRESSION $REPOSITORY::$ARCHIVE $TARGETS

notify-send Backup "Done. Checking."
borg check --verbose --last=1 $REPOSITORY

notify-send Backup "Check done. Finished."
exit 0
