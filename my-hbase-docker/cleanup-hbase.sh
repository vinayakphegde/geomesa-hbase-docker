#!/bin/sh -xe

. /build/config.sh
rm -rf /tmp/* /var/tmp/*

microdnf clean all
rm -rf /var/lib/apt/lists/*
