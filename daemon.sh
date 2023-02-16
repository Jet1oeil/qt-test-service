#! /bin/sh
### BEGIN INIT INFO
# Provides: jet1oeil-monitor
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: start jet1oeil-monitor as daemon
### END INIT INFO

# Author: Contact Jet1oeil <contact@jet1oeil.com>

# Do NOT "set -e"

# PATH should only include /usr/* if it runs after the mountnfs.sh script
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="Qt test service"
NAME=qt-service-test
DAEMON=${PWD}/build/$NAME
DAEMON_ARGS="--daemon"
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

USERNAME=root

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.2-14) to ensure that this file is present
# and status_of_proc is working.
. /lib/lsb/init-functions

#
# Function that starts the daemon/service
#
do_start()
{
	# start-stop-daemon will return
	#   0 if daemon has been started
	#   1 if daemon was already running
	#   2 if daemon could not be started

	# Checking if already started
	log_daemon_msg "Starting $NAME ($DESC)"
	log_progress_msg "checking"
	start-stop-daemon --start --quiet --exec $DAEMON --chuid $USERNAME --test > /dev/null
	RETVAL="$?"
	if [ "$RETVAL" != 0 ]; then
		log_end_msg 1
		exit 1
	fi

	# Starting it
	log_progress_msg "deamon"
	start-stop-daemon --start --quiet --exec $DAEMON --chuid $USERNAME -- $DAEMON_ARGS
	RETVAL="$?"
	if [ "$RETVAL" != 0 ]; then
		log_end_msg 2
		exit 2
	fi
	log_end_msg 0
	# Add code here, if necessary, that waits for the process to be ready
	# to handle requests from services started subsequently which depend
	# on this one.  As a last resort, sleep for some time.
}

#
# Function that stops the daemon/service
#
do_stop()
{
	# start-stop-daemon will return
	#   0 if daemon has been stopped
	#   1 if daemon was already stopped
	#   2 if daemon could not be stopped
	#   other if a failure occurred

	# Stopping 
	log_daemon_msg "Stopping $NAME ($DESC)"

	log_progress_msg "deamon"
	start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --exec $DAEMON
	RETVAL="$?"
	if [ "$RETVAL" = 2 ]; then
		log_end_msg 2
		return 2
	fi
	log_end_msg 0

	# Many daemons don't delete their pidfiles when they exit.
	# rm -f $PIDFILE
	return "$RETVAL"
}

#
# Function that sends a SIGHUP to the daemon/service
#
do_reload() {
	#
	# If the daemon can reload its configuration without
	# restarting (for example, when it is sent a SIGHUP),
	# then implement that here.
	#
	start-stop-daemon --stop --signal 1 --quiet --pidfile $PIDFILE --name $NAME
	return 0
}

case "$1" in
  start)
	do_start
	;;
  stop)
	do_stop
	;;
  status)
	status_of_proc "$DAEMON" "$NAME" && exit 0 || exit $?
	;;
  #reload|force-reload)
	#
	# If do_reload() is not implemented then leave this commented out
	# and leave 'force-reload' as an alias for 'restart'.
	#
	#log_daemon_msg "Reloading $DESC" "$NAME"
	#do_reload
	#log_end_msg $?
	#;;
  restart|force-reload)
	#
	# If the "reload" option is implemented then remove the
	# 'force-reload' alias
	#
	do_stop
	case "$?" in
	  0|1)
		do_start
		;;
	  *)
		;;
	esac
	;;
  *)
	#echo "Usage: $SCRIPTNAME {start|stop|restart|reload|force-reload}" >&2
	echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
	exit 3
	;;
esac

:
