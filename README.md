# Jenkins-Git-Redmine

# 参考
* [Gitlab-CEの本家Dockerリポジトリ](https://hub.docker.com/r/gitlab/gitlab-ce/tags)
* [GitLab-CEの本家Dockerソースリポジトリ](https://gitlab.com/gitlab-org/omnibus-gitlab)
 ※表示すると画面右上にクローン用のアドレスがあるのでコピーする

# 起動後の操作
## SlackとGitlabの連携
* Webでワークスペースを表示する
* 右上の管理をクリック
* 左上のカスタムインテグレーションをクリック
* Incoming Webhookをクリック
* チャネル（投稿先）を選択してあとは適当に入力する
* Webhook URLをコピーして、それをGitlabで入力する

## Gitlabで連携の確認
* コンテナを起動する
* ※かなり時間がかかる
* 指定したポートで接続してみる
 http://elara.syh.socionext.com:10180/
* 問題が発生した場合はポートが開いているか、起動が終わっているかを確認する
 root/指定したパスワード でログインする
* プロジェクトを作成する。この場合はadmin-testで
 http://elara.syh.socionext.com:10180/root/admin-test/
* 左の歯車アイコンからの、Integrationで下の方のSlack Notificationをクリック
* activeをチェック
* WebHookアドレスにSkackのWebHookを張り付けて、下のテストを行う

# 内容

## 共通部

### フォルダ
* .gitignore
* .env:コンテナの実行時に引き渡される環境変数ファイル。gitには保存しない
* README.md:このファイル
* docker-compose.yml:
* create-env.sh:環境変数から.envファイルを作成するスクリプト

## Gitlab
サブフォルダのgitlabをビルドして使用する  
[ここで](https://docs.gitlab.com/omnibus/docker/#run-the-image)動かし方が書いてあるので


### フォルダ
```
Dockerfile
resource/
	assets/
		wrapper:初期実行コマンド、初回実行時にproxyが設定されていたらproxy設定をgitlab.rbに追加する
	opt/gitlab/etc/
		proxy.rb.template:gitlab.rbファイルに追加するテンプレート
```

## Jenkins

## Redmine

