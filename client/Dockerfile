# docker環境の基本となるイメージを指定(Docker Hubから選択しています)
FROM node:alpine3.13

# このdocker環境の環境変数を指定
#nodeのバージョンを指定
ENV NODE_VERSION=14.15.4
#development環境を指定
ENV NODE_ENV=development
#docker環境のタイムゾーンを指定
ENV TZ=Asia/Tokyo

# Reactを動かすために必要な各種ミドルウェア等をインストール
RUN apk add --no-cache alpine-sdk linux-headers libxml2-dev tzdata \
    gcc libc-dev gmp-dev sudo bash curl vim git wget && \
    apk add --virtual build-dependencies --no-cache build-base curl-dev && \
    # docker環境にclient用のディレクトリを作成&移動
    cd /var && mkdir -p www/html/app/ec_cart/client && \
    cd www/html/app/ec_cart/client

# ローカルからDockerに入った時に最初にいるディレクトリを指定
WORKDIR /var/www/html/app/ec_cart/client

# build(dockerイメージを作成する)時にローカルからdockerイメージに指定のファイルをコピーする
# 後ほど、entrypoint.shを作成するので、そのファイルをdockerの/usr/bin/にコピーします。
COPY . .
COPY ./package.json /var/www/html/app/ec_cart/client/
COPY ./entrypoint.sh /usr/bin/

# entrypoint.shのファイル実行権限を変更する。
RUN chmod +x /usr/bin/entrypoint.sh

# # build後にdockerコンテナを起動(run)する際に上記でコピーしたentrypoint.shを実行する。(ファイルに記載のコ
ENTRYPOINT ["entrypoint.sh"]

# 使用するポート番号を指定する。
EXPOSE 3000