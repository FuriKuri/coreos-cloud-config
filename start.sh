#!/bin/sh

echo "prepare files"
mkdir .build

ETCD_DISCOVERY=$(curl -w "\n" 'https://discovery.etcd.io/new?size=3')

echo "use $ETCD_DISCOVERY"

sed "s%<your_discovery_url>%$ETCD_DISCOVERY%g" <worker.yml >.build/worker.yml
sed "s%<your_discovery_url>%$ETCD_DISCOVERY%g" <service.yml >.build/service.yml
