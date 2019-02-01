#!/usr/bin/env bash
PIDFILE=pid
kill `cat $PIDFILE`
rm -f $PIDFILE