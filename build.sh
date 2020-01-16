#!/bin/bash -e
docker-compose down || echo ""
docker volume rm noproxy_jenkins-master || echo ""
docker-compose build --no-cache --build-arg="http_proxy=$http_proxy" --build-arg="https_proxy=$https_proxy"
