#!/bin/bash
export WEBHOOK_PATH=${WEBHOOK_PATH:-/webhook}
export BRANCH=${BRANCH:-master}

/pull.sh

github-webhook \
  --port=9999 \
  --path=$WEBHOOK_ENDPOINT \
  --secret=$WEBHOOK_SECRET \
  --log=/var/log/webhook.log \
  --rule="push:ref == refs/heads/$BRANCH:/pull.sh" &

jekyll build --watch --source /source --destination /site &

sed "s|\\\$WEBHOOK_ENDPOINT|$WEBHOOK_ENDPOINT|g" /site.conf > /etc/nginx/sites-available/default

nginx &

wait

