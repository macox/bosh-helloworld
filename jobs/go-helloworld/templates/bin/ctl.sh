#!/bin/bash

APP_DIR=/var/vcap/sys/run/go-helloworld
LOG_DIR=/var/vcap/sys/log/go-helloworld
PIDFILE=${APP_DIR}/pid
RUN_USER=vcap

case $1 in

    start)
        mkdir -p $APP_DIR $LOG_DIR
        chown -R $RUN_USER:$RUN_USER $APP_DIR $LOG_DIR

        echo $$ > $PIDFILE

        cd /var/vcap/packages/go-helloworld

        exec /var/vcap/packages/go-helloworld/bin/go-helloworld \
             >>  $LOG_DIR/go_helloworld.stdout.log \
             2>> $LOG_DIR/go_helloworld.stderr.log

        ;;

    stop)
        kill -9 `cat $PIDFILE` && rm -f $PIDFILE
        ;;

    *)
        echo "Usage: ctl {start|stop}" ;;
        
    esac
