#!/bin/bash -e
CONTAINERS=jenkins
# https_proxyが設定されていた場合はproxyありの環境と認識する
if [ "$https_proxy" != '' ]; then
    # ビルド時に使用する環境変数
    if [ "$no_proxy" == '' ]; then
        no_proxy=localhost,127.0.0.1,*.${HOSTNAME#*.}
    fi
    # 実行時は隣のコンテナへもproxyは必要ない
    if [ "$CONTAINERS" == '' ]; then
        no_proxy=$no_proxy,$CONTAINERS
    fi
    # 環境変数を.envに出力します
    echo http_proxy=$http_proxy > .env
    echo https_proxy=$https_proxy >>.env
    echo no_proxy=$no_proxy >> .env
else
    # proxy設定がない場合はファイルだけ作成する
    if [ ! -e .env ]; then
        touch .env
    fi
fi
