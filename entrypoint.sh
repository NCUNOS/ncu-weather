#!/bin/sh

sleep 5 # wait for mongo start up
build/crawler &
build/web
