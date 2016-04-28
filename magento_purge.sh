#/bin/bash

if [ $# -eq 0 ]
  then
    echo
    echo "Usage: $0 <service_id> <URL to purge>"
    echo 
    exit
fi

hmacKey=$1
siteURL=$2

# getting rid of beggining http/https
urlPath=`echo -n $siteURL | sed 's|^http[s]*://||'`

# getting rid of domain.name
urlPath=`echo -n $urlPath | sed 's|^[a-z0-9.]*/*|/|'`

unixTime=`date +%s`
let unixTime+=5 # set expiration +5s in the future

hmacMessage=`echo -n $urlPath$unixTime | openssl sha1 -hmac $hmacKey`

purgeToken=$unixTime"_"$hmacMessage

curl -svX PURGE -H "X-Purge-Token: $purgeToken" $2

