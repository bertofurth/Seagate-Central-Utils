#!/bin/sh
### BEGIN INIT INFO
# Provides:          motion
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: motion
# Description:       motion movement detection
# Author:            Berto Furth
# Version:           0.1
### END INIT INFO

#
# This is a very basic startup script for "motion"
# on the Seagate Central. Copy this script
# into the /etc/init.d/ directory and enable it
# with a command similar to
#
# update-rc.d motion-init.sh defaults 77
#
# Note that this simple script works on the assumption
# that there is only one instance of the daemon running.
#
DESC="motion"
LONGDESC="motion movement detection"
NAME=motion
DAEMON=/usr/local/bin/$NAME

# Specify log file in configuration file
# and store it on non volatile media as
# it can be used to track events.
#LOG=/var/log/motion.log

PIDFILE=/var/run/$DESC.pid
USER=motion
CONFIG=/usr/local/etc/motion/motion.conf
ARGS="-b -c $CONFIG -p $PIDFILE "

[ -x $DAEMON ] || exit 0

start_daemon() {
        touch $PIDFILE
        chown $USER $PIDFILE
    	echo "Starting $LONGDESC: $NAME"
      	start-stop-daemon --chuid $USER --start --verbose --exec $DAEMON -- $NEW_ARGS	
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
    restart|force-reload)
	stop_daemon
	sleep 4
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
      echo "  $0 {start|stop|restart|force-reload|status}"
      echo ""
      exit 3
    ;;
esac

exit 0

