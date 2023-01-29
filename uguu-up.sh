#!/bin/bash
curl -s -F files[]=@${1} https://uguu.se/upload.php | jq -r '.files[]|.name + ": " +.url'
