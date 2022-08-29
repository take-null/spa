# gem 'rails', '~> 7' はRuby2.7.0以上が必須で3.0以上が望ましい
# 軽量なalpineを選択(バージョンも固定した方が安定性は増す)
FROM ruby:3.0.2-alpine3.13

# docker-compose.ymlで具体的に指定(./back)
ARG WORKDIR

# Dockerイメージで使用する環境変数
# イメージからコンテナへ渡され、コンテナへ渡されると、コンテナ内で起動したアプリケーションで参照可
ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql git imagemagick yarn" \
    DEV_PACKAGES="build-base curl-dev" \
    HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR ${HOME}

# ローカルファイルをイメージにコピーする
# *は「Gemfileで始まるファイル名全て」という意味
# ローカルのGemfileと名前が付くもの全てをイメージの./backにコピーする
COPY Gemfile* ./

# --no-cashe ローカルにキャッシュせずコンテナを軽量に保つためのオプション
# --virtual <name> このオプションを付けるとひとまとめにされ新たなパッケージとなり、nameで呼び出せる
# -j4 並列処理でインストールを高速化
# 最後にRailsの起動に不必要なものをdelで削除
RUN apk add --update --no-cache less && \
    #apk update --no-cache less && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install --jobs=4 --retry=3 && \
    apk del build-dependencies

# ローカルにあるものを全てイメージにコピー
COPY . .

EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]