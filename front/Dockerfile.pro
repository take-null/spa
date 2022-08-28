# node:14は不可
FROM node:16.14-alpine

ARG WORKDIR

# .envで3000番を指定docker-compose.ymlでは8080を指定しているのでダブらないように
ARG CONTAINER_PORT

ARG API_URL

ARG API_URL_BROWSER

ARG ENV_FILE

# HOST=0.0.0.0はブラウザから「http://localhost」にアクセスするための環境変数
ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \
    API_URL=${API_URL} \
    API_URL_BROWSER=${API_URL_BROWSER} \ 
    ENV_FILE=${ENV_FILE}

WORKDIR ${HOME}

COPY package*.json ./
RUN yarn install
RUN echo ${ENV_FILE} | base64 --decode > .env 
COPY . ./
RUN yarn run 

#RUN yarn run build

#EXPOSE 3000

#CMD ["yarn", "dev"]