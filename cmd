#!/usr/bin/env sh

cat /tmp/hosts >> /etc/hosts; exec java ${JAVA_OPTS} -cp . org.springframework.boot.loader.WarLauncher