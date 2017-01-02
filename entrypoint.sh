#!/bin/bash -x


# Setup network
ip addr flush ${UCARP_INTERFACE}
ip addr add ${UCARP_SOURCEADDRESS}/${UCARP_SOURCEPREFIX} dev ${UCARP_INTERFACE}

PIDFILE=/tmp/ucarp.pid

trap "shutdown" SIGINT SIGTERM

shutdown() {
  RET=$1
  echo "Shutting down"
  PID=`cat $PIDFILE`
  if [ -z "$PID" ]
  then
    echo "ucarp pid not found"
    exit 99
  fi

  echo "Demoting master"
  kill -USR2 $PID
  sleep 1
  echo "Sending TERM to ucarp"
  kill $PID
  sleep 1
  echo "Sending KILL to ucarp" # we need to make sure everything is dead before
  kill -9 $PID                 # ucarp might promote itself to master afer 3s again
  exit $RET
}

( /usr/local/sbin/haproxy -f /etc/haproxy/haproxy.cfg; shutdown 2 ) &

/usr/sbin/ucarp \
   --interface=${UCARP_INTERFACE} \
   --srcip=${UCARP_SOURCEADDRESS} \
   --vhid=${UCARP_VHID} \
   --pass=${UCARP_PASS} \
   --addr=${UCARP_VIRTUALADDRESS} \
   --upscript=${UCARP_UPSCRIPT} \
   --downscript=${UCARP_DOWNSCRIPT} \
   --nomcast &

echo $! > $PIDFILE
wait $!
