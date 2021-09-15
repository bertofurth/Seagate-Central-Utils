#!/bin/sh
### BEGIN INIT INFO
# Provides:          minidlna
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: minidlna
# Description:       miniDLNA (AKA ReadyMedia) media server
# Author:            Berto Furth
# Version:           0.1
### END INIT INFO

#
# This is a very basic startup script that works
# on the assumption that there is only one 
# instance of the daemon running.
#
DESC="minidlna"
LONGDESC="miniDLNA (AKA ReadyMedia) media server"
NAME=minidlnad
DAEMON=/usr/local/sbin/$NAME
LOG=/var/log/minidlna.log
PIDFILE=/var/run/$DESC.pid
USER=minidlna
ARGS="-u $USER -P $PIDFILE"

[ -x $DAEMON ] || exit 0

start_daemon() {
        touch $LOG
        chown $USER $LOG
    	echo "Starting $LONGDESC: $NAME"
      	start-stop-daemon --start --pidfile $PIDFILE --verbose --exec $DAEMON -- $NEW_ARGS	
    	echo "done"
}

stop_daemon(){
	echo "Stopping $LONGDESC: $NAME"
   	if [ -e $PIDFILE ]; then
      		start-stop-daemon --stop --verbose --pidfile $PIDFILE
        	rm $PIDFILE
	else
		PID=$(pidof -s $DAEMON)
        	if [ ! -z $PID ]; then
          		PIDS=$(pidof $DAEMON)
          		kill $PIDS
                else
 			echo "$NAME not running"
        	fi	
	fi
	echo "done"
}



case "$1" in
    start)
        NEW_ARGS="$ARGS"
        start_daemon
        ;;
    stop)
        stop_daemon
        ;;
    rebuild)
        NEW_ARGS="$ARGS -R"
        start_daemon
 	;;
    rescan)
        NEW_ARGS="$ARGS -r"
        start_daemon
        ;;
    restart|force-reload)
	stop_daemon
	sleep 1
        NEW_ARGS="$ARGS"
	start_daemon
        ;;
    status)
        PID=$(pidof -s $DAEMON | head -1)
	if [ -z $PID ]; then
	  echo "$NAME not running"
	else
          PID=$(pidof $DAEMON | head -1)
	  echo "$NAME running on PID $PID"
	fi

        ;;
    *)
      echo ""
      echo $DESC
      echo "------------------"
      echo "Syntax:"
      echo "  $0 {start|stop|restart|force-reload|rebuild|rescan|status}"
      echo ""
      exit 3
    ;;
esac

exit 0

