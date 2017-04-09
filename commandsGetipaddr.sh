#!/bin/bash

ifconfig | grep 172.17 | awk '{print $2}' | awk -F: '{print $2}'
