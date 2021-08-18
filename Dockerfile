FROM    openjdk:8

MAINTAINER Hoang Manh Ha <ha@zo-ta.com>

ENV     TZ 'Asia/Ho_Chi_Minh'

RUN	mkdir -p /opt/ewallet

WORKDIR /java-app

ADD		hosts /tmp/

ADD     cmd bin/cmd
RUN     chmod +x bin/cmd

ADD     target/java-app/WEB-INF/lib WEB-INF/lib
ADD     target/java-app .


CMD     ["bin/cmd"]

EXPOSE  12141