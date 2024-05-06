#!/bin/sh

if test -x /bin/ss
then
	exec watch -t ss -putsw
else
	exec netstat -c
fi
