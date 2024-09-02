#!/bin/bash

bundle exec rspec
count=0
while [ $? -eq 0 ]; do
  bundle exec rspec
  count=$((count+1))
  if [ $count -eq 10 ]; then
    break
  fi
done

notify-send "lpda2 rspec" "Il comando è terminato."
