#! /bin/bash -e
file_revert() {
    # 元ファイルが存在すればそのファイルに戻す。
    # 元がなければ削除する
    if [ -e $1 ]; then
        if [ -e $1.orig ]; then
            cp $1.orig $1
            rm $1.orig
        else
            rm $1
        fi
    fi
    return 0
}
bkup_file(){
    mkdir -p ${1%/*}
    if [ -e $1 ]; then
        cp $1 $1.orig
    fi
    return 0
}
svn_proxy(){
    # フォルダがなければ作成
    bkup_file $1
    if [ ! -e $1 ]; then
        # ファイルがなかった場合のみglobalを出力
        echo "[global]" >> $1
    fi
    if [ "$4" != '' ]; then
        echo http-proxy-username=$4 >> $1
        echo http-proxy-password=$5 >> $1
        echo ssl-trust-default-ca = yes >> $1
    fi
    echo http-proxy-host=$2 >> $1
    echo http-proxy-port=$3 >> $1
    echo http-proxy-exceptions=$no_proxy >> $1
    return 0
}
mvn_proxy(){
    # MAVEN関連の設定
    if [ "$MAVEN_NO_PROXY" == '' ]; then
        MAVEN_NO_PROXY="${no_proxy//,/|}"
    fi
    bkup_file $1
    if [ ! -e $1 ]; then
        # ファイルが存在しなければ作成する
        echo "<settings><proxies>" >> $1
        echo "</proxies></settings>" >> $1
    fi
    if [ "$4" != '' ]; then
        MAVEN_PROXY="<proxy><id>optional</id><active>true</active><protocol>http</protocol><username>$4</username><password>$5</password><host>$2</host><port>$3</port><nonProxyHosts>$MAVEN_NO_PROXY</nonProxyHosts></proxy>"
    else
        MAVEN_PROXY="<proxy><id>optional</id><active>true</active><protocol>http</protocol><host>$2</host><port>$3</port><nonProxyHosts>$MAVEN_NO_PROXY</nonProxyHosts></proxy>"
    fi
    sed -e "s:<proxies>:<proxies>$MAVEN_PROXY:g" -i $1
    return 0
}
if [ "$https_proxy" != '' ]; then
    if [ "`id -u`" != 0 ]; then
        SVN_PROXY_FILE=~/.subversion/servers
    else
        SVN_PROXY_FILE=/etc/subversion/servers
    fi
    MVN_SETTING_FILE=~/.m2/settings.xml

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

    if [ "$1" = '' ]; then
        set -- revert subversion maven
    fi
    while [ "$1" != "" ]
    do
      case $1 in
        revert)
          file_revert $SVN_PROXY_FILE
          file_revert $MVN_SETTING_FILE
          ;;
        svn|subversion)
          svn_proxy $SVN_PROXY_FILE $PROXY_HOST $PROXY_PORT $PROXY_USER $PROXY_PW
          ;;
        mvn|maven)
          mvn_proxy $MVN_SETTING_FILE $PROXY_HOST $PROXY_PORT $PROXY_USER $PROXY_PW
          ;;
        *)
          echo Unknown target \($1\).
          exit 1
          ;;
      esac
      shift
    done
fi
