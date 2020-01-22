FROM sameersbn/redmine:4.1.0
# https://qiita.com/iwa-na/items/56b44bf8baebe3698dda
# GitLabの プロジェクト ->Settings->Integrations->Project services->Redmine
# これは外から見たURLを指定しないとだめ
# User Settings->SSH Keys を設定するとあるが、特に設定しなくても動いているのは
# リポジトリにパスワードを設定したからか？
RUN cd plugins & git clone https://github.com/koppen/redmine_github_hook.git

