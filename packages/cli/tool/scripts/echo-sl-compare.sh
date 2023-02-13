#!/bin/bash

mkdir -p $1
cd $1

wget 'https://www.sqlite.org/2022/sqlite-tools-osx-x86-3400100.zip'
unzip sqlite-tools-osx-x86-3400100.zip
rm sqlite-tools-osx-x86-3400100.zip
mv sqlite-tools-osx-x86-3400100 sqlite-tools-osx

wget 'https://sbp.enterprisedb.com/getfile.jsp?fileid=1258319' -O pgsql.zip
unzip pgsql.zip
rm pgsql.zip

for pod_index in {0..4}
do
    pod="echo-$pod_index"
    mkdir -p $pod
    
    kubectl -n echo-prod exec -ti $pod -- apt-get update 
    kubectl -n echo-prod exec -ti $pod -- apt-get install -y sqlite3

    kubectl -n echo-prod exec -ti $pod -- sqlite3 /var/lib/sqlite/message.db ".dump" > $pod/sqlite-dump-all.sql
    
    rm -f $pod/echo-sl-compare.sqlite

    ./sqlite-tools-osx/sqlite3 $pod/echo-sl-compare.sqlite ".read ${pod}/sqlite-dump-all.sql"
    ./sqlite-tools-osx/sqlite3 $pod/echo-sl-compare.sqlite "ALTER TABLE chat RENAME TO chat_echo;"
    ./sqlite-tools-osx/sqlite3 $pod/echo-sl-compare.sqlite "ALTER TABLE user RENAME TO user_echo;"
    ./sqlite-tools-osx/sqlite3 $pod/echo-sl-compare.sqlite "ALTER TABLE message RENAME TO message_echo;"

    chat_names=`kubectl -n echo-prod exec -ti $pod -- env | grep CHATS_NAMES_$pod_index | sed "s/CHATS_NAMES_$pod_index=//g" | sed 's/\[//g' | sed 's/\]//g' | sed 's/"/\x27/g'`
    echo $chat_names

    ./sqlite-tools-osx/sqlite3 $pod/echo-sl-compare.sqlite "
CREATE TABLE IF NOT EXISTS chat_sl (
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    id integer NOT NULL,
    chat_id bigint,
    title character varying,
    group_username character varying,
    account_id integer,
    blacklisted boolean,
    blacklisted_reason character varying,
    messages_read integer,
    last_message_timestamp timestamp with time zone,
    last_message_id bigint,
    bot_amount integer,
    priority integer,
    is_public_channel boolean,
    access_hash bigint,
    participants_count integer,
    average_online_count integer
);
CREATE TABLE IF NOT EXISTS message_sl (
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    id bigint NOT NULL,
    message_id bigint,
    user_id bigint,
    chat_id bigint,
    date timestamp without time zone,
    text character varying,
    views integer,
    replies integer,
    forwards integer,
    online_count integer,
    reply_to_id bigint,
    account_id integer
);
CREATE TABLE IF NOT EXISTS user_sl (
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    id integer NOT NULL,
    user_id bigint,
    first_name character varying,
    last_name character varying,
    username character varying,
    bot boolean,
    verified boolean,
    scam boolean,
    fake boolean
);"

    echo "
CREATE TABLE IF NOT EXISTS
    chat_export 
(LIKE chat
EXCLUDING ALL);


DELETE FROM
    chat_export;

INSERT INTO
    chat_export
SELECT
    *
FROM
    chat
WHERE
    group_username in ($chat_names);
    " | ./pgsql/bin/psql -q $PG_URI

    ./pgsql/bin/pg_dump $PG_URI -t chat_export --column-inserts -a -f $pod/pgsql-dump-chat.sql
    
    sed -i.bak '/^INSERT/!d' $pod/pgsql-dump-chat.sql
    sed -i.bak 's/public\.//g' $pod/pgsql-dump-chat.sql
    sed -i.bak 's/chat_export/chat_sl/g' $pod/pgsql-dump-chat.sql

   ./sqlite-tools-osx/sqlite3 $pod/echo-sl-compare.sqlite ".read ${pod}/pgsql-dump-chat.sql"
 
done
