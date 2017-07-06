#!/bin/bash

cd /usr/local/src/test/build
./test-app

echo test-app exited with code $?

while :
do
    sleep 10
done
