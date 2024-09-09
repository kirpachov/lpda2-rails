#!/bin/bash

docker build . -t lpda2-rails:latest && \
  docker tag lpda2-rails:latest kirpachov/lpda2-rails:latest && \
  docker push kirpachov/lpda2-rails:latest && \
  echo "Done"