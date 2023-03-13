#!/bin/bash

# For k8s
# Set different env vars from config map

HOSTNAME_INDEX=${HOSTNAME##*-}

API_ID_VAR_NAME="API_ID_$HOSTNAME_INDEX"
API_ID=${!API_ID_VAR_NAME}

API_HASH_VAR_NAME="API_HASH_$HOSTNAME_INDEX"
API_HASH=${!API_HASH_VAR_NAME}

PHONE_VAR_NAME="PHONE_$HOSTNAME_INDEX"
PHONE=${!PHONE_VAR_NAME}

PROXY_OPTION_VAR_NAME="PROXY_OPTION_$HOSTNAME_INDEX"
PROXY_OPTION=${!PROXY_OPTION_VAR_NAME}

CHATS_NAMES_VAR_NAME="CHATS_NAMES_$HOSTNAME_INDEX"
CHATS_NAMES=${!CHATS_NAMES_VAR_NAME}

/app/echo \
    --api-id $API_ID \
    --api-hash $API_HASH \
    --phone-number $PHONE \
    --libtdjson-path $PATH_TD_JSON_LIB \
    --loglevel $LOG_LEVEL \
    --libtdjson-loglevel $LIBTDJSON_LOGLEVEL \
    --database-path $PATH_TD_JSON_LIB_DATA \
    --message-database-path $PATH_DB_MESSAGE \
    $PROXY_OPTION \
    messages \
    --chats-names $CHATS_NAMES \
    --run-forever $RUN_FOREVER \
    --table-dump-path $TABLE_DUMP_PATH \
    --ipfs-cron-schedule "$IPFS_CRON_SCHEDULE" \
    --ipfs-scheme $IPFS_SCHEME \
    --ipfs-host $IPFS_HOST \
    --ipfs-port $IPFS_PORT \
    $IPFS_USERNAME \
    $IPFS_PASSWORD 
