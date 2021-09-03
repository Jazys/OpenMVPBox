#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir postgres-data
