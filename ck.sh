#!/bin/bash
S="$1"
shift
shift
for arg in "$@"; do
  grep "$S" ${arg} > /dev/null
  if [ $? = 0 ]; then
     echo -------------- ${arg}
     grep "$S" ${arg}
  fi
done

