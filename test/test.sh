#!/bin/bash -e
echo server:%HOSTNAME
echo port:$1
USER=root
PW=testtest
PRJ=admin-test
if [[ ! -d $PRJ ]]; then
  echo gitのバージョンが古い場合はno_proxyに自ホストが入ってないとエラーになります。
  echo no_proxy:$no_proxy
  # git clone http://$USER:$PW@$HOSTNAME:$1/$USER/$PRJ.git
  git clone http://$USER:$PW@localhost:$1/$USER/$PRJ.git
else
  echo gitのフォルダが存在しています
fi
JENKINS_HOST=master
pushd ..
echo jenkinsの初期パスワードは
docker-compose exec $JENKINS_HOST cat /var/jenkins_home/secrets/initialAdminPassword 
popd
