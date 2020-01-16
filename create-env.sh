#!/bin/bash -e
CONTAINERS=gitlab,redis,postgresql,redmine,redmine-db,master
# https_proxyが設定されていた場合はproxyありの環境と認識する
if [ "$https_proxy" != '' ]; then
    # ビルド時に使用する環境変数
    if [ "$no_proxy" == '' ]; then
        no_proxy=localhost,127.0.0.1
    fi
    # 実行時は隣のコンテナへもproxyは必要ない
    if [ "$CONTAINERS" != '' ]; then
        no_proxy=$no_proxy,${HOSTNAME#*.},$CONTAINERS
    fi
    # 環境変数を.envに出力します
    echo http_proxy=$http_proxy > .env
    echo https_proxy=$https_proxy >>.env
    echo no_proxy=$no_proxy >> .env
    if [ "$https_proxy" != '' ]; then
        # https_proxyを分解します
        PROXY_STR=${https_proxy/*:\/\//}
        WORK=${PROXY_STR%@*}
        PROXY_USER=""
        PROXY_PW=""
        if [ "$WORK" != "$PROXY_STR" ]; then
            PROXY_USER=${WORK%:*}
            PROXY_PW=${WORK#*:}
            WORK=${PROXY_STR#*@}
        fi
        PROXY_HOST=${WORK%:*}
        PROXY_PORT=${WORK#*:}
        #echo JAVA_OPTS="-Duser.timezone=Asia/Tokyo -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxy=${PROXY_PORT} -Dhttp.proxyPort=${PROXY_PORT} -Dhttps.proxyHost=${PROXY_HOST} -Dhttps.proxyPort=${PROXY_PORT}" >> .env
        #echo JAVA_OPTS="-Duser.timezone=Asia/Tokyo" >> .env
    fi
else
    #echo JAVA_OPTS="-Duser.timezone=Asia/Tokyo" > .env
    touch .env
fi
