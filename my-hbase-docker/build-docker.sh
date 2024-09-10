#!/bin/bash

set -ex

rm -rf docker-tmp

mkdir docker-tmp

cp my-hbase-docker/* docker-tmp

docker build -t vhegde/hbase-docker ./docker-tmp

rm -rf docker-tmp