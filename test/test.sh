#!/bin/bash -e
echo server:%HOSTNEME
echo port:$1
USER=root
PW=testtest
PRJ=admin-test
echo gitのバージョンが古い場合はno_proxyに自ホストが入ってないとエラーになります。
echo no_proxy:$no_proxy
git clone http://$USER:$PW@$HOSTNAME:$1/$USER/$PRJ.git

