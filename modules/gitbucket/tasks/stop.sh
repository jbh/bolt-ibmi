!#/QOpenSys/pkgs/bin/bash

pid_path="$PT_gitbucket_path/gitbucket.pid"
pid=$(cat $pid_path)

kill $pid && rm $pid_path
