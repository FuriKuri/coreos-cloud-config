#!/bin/sh

echo "Precheck cloud configs"

if [ ! -d ".build" ]; then
  echo "Create .build directory"
  mkdir .build
fi

if [ ! -f ".build/service.yml" || ! -f ".build/worker.yml"  ]; then
  echo "Remove old files"

  if [ ! -f ".build/worker.yml"  ]; then
    echo "Remove old worker.yml"
    rm .build/worker.yml
  fi

  if [ ! -f ".build/service.yml"  ]; then
    echo "Remove old service.yml"
    rm .build/service.yml
  fi

  ETCD_DISCOVERY=$(curl -w "\n" 'https://discovery.etcd.io/new?size=3')

  echo "use $ETCD_DISCOVERY"

  sed "s%<your_discovery_url>%$ETCD_DISCOVERY%g" <worker.yml >.build/worker.yml
  sed "s%<your_discovery_url>%$ETCD_DISCOVERY%g" <service.yml >.build/service.yml
fi
