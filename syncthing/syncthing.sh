#!/bin/sh
### BEGIN INIT INFO
# Provides:          syncthing
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: syncthing
# Description:       syncthing
# Author:            Berto Furth
# Version:           0.1
### END INIT INFO

#
# Startup script for syncthing on the Seagate Central
#
# Recent versions of syncthing don't work well with
# "init". This is a very basic startup script that
# works on the assumption that there is only one 
# instance of syncthing running at a time.
#

DESC="Syncthing"
NAME=syncthing
DAEMON=/usr/bin/$NAME
LOG=/var/log/$NAME
USER=syncthing

[ -x $DAEMON ] || exit 0

start_daemon () {
        # Increase UDP buffer size as per syncthing docs
        sysctl -w net.core.rmem_max=2500000

        touch $LOG
        chown $USER $LOG
   
        # Start syncthing GUI on port 8384. This may not 
        # be desirable for everyone as it can be a security
        # issue.
        su -c "$DAEMON -logfile=$LOG -gui-address=[::]:8384" $USER &
}

stop_daemon () {
        PID=$(pidof -s $DAEMON | head -1)
	if [ ! -z $PID ]; then
	  kill $PID
	fi
}


case "$1" in
    start)
        logger "Starting $DESC"
        start_daemon
        ;;
    stop)
        logger "Stopping $DESC" "$NAME"
        stop_daemon
        ;;
    reload)
        logger "Can't reloading $DESC" "$NAME"
        echo "$NAME doesn't respond to SIGHUP. Try restart."
        ;;
    restart|force-reload)
        logger "Restarting $DESC"
	stop_daemon
	sleep 10
	start_daemon
        ;;
    status)
        PID=$(pidof -s $DAEMON | head -1)
	if [ -z $PID ]; then
	  echo "$NAME not running"
	else
	  echo "$NAME running on PID $PID"
	fi

        ;;
    *)
      echo ""
      echo "syncthing server"
      echo "------------------"
      echo "Syntax:"
      echo "  $0 {start|stop|restart|reload|status}"
      echo ""
      exit 3
    ;;
esac

exit 0

