#!/bin/sh

ls
echo "ok $1 $GITHUB_EVENT_NAME" > "$2"
ls
