#!/bin/bash

cmd=$1
next_host=$2

dir=/root
port=11208
#tar_option=z
tar_option=

pipe=/tmp/chained_copy_pipe

if [ "$cmd" = up ]; then
    if [ -n "$next_host" ]; then
        test -e $pipe && /bin/rm -f $pipe
        mkfifo $pipe
        nc $next_host $port < $pipe >/dev/null &
        disown
        nc -l $port | tee -a $pipe | tar xf$tar_option - -C $dir >/dev/null &
        disown
    else
        nc -l $port | tar xf$tar_option - -C $dir >/dev/null &
        disown
    fi
elif [ "$cmd" = down ]; then
   pkill -f "^nc .* $port"
elif [ "$cmd" = status ]; then
   pgrep -af "^nc .* $port"
else
    echo "usage:" 
    echo "  1. on node[-1]: $0 up"
    echo "  2. on node[-2]: $0 up node[-1]"
    echo "  3. ..."
    echo "  4. tar cf$tar_option - * | nc node[0] $port"
    exit 1
fi
