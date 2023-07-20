#!/bin/bash

nohup java -jar $PT_gitbucket_path/gitbucket.war > /dev/null 2>&1 &
echo $! > $PT_gitbucket_path/gitbucket.pid
