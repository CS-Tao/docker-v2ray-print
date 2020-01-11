FROM nikolaik/python-nodejs:python3.7-nodejs13-alpine

RUN apk update && \
    apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    npm i qrcode-terminal@0.12.0

COPY config.json /var/v2ray/info/config.json
COPY index.js /var/v2ray/info/index.js
COPY entrypoint.sh /var/v2ray/info/entrypoint.sh
COPY json2vmess.py /var/v2ray/info/json2vmess.py

RUN chmod +x /var/v2ray/info/entrypoint.sh

WORKDIR /var/v2ray/info/

ENTRYPOINT ["./entrypoint.sh"]

