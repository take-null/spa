FROM node:16.14-alpine

ARG WORKDIR

ARG CONTAINER_PORT

ARG API_URL

ARG API_URL_BROWSER

ARG ENV_FILE

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \
    API_URL=${API_URL} \
    API_URL_BROWSER=${API_URL_BROWSER} \ 
    ENV_FILE=${ENV_FILE}

WORKDIR ${HOME}

RUN apk add --update coreutils && \
    echo ${ENV_FILE} | base64 --decode > .env

COPY package*.json ./

RUN yarn install

COPY . ./

RUN yarn run 