FROM nikolaik/python-nodejs:python3.7-nodejs13-alpine

RUN apk update && \
    apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    npm i qrcode-terminal@0.12.0

COPY index.js /var/v2ray/index.js
COPY entrypoint.sh /var/v2ray/entrypoint.sh
COPY json2vmess.py /var/v2ray/json2vmess.py

RUN chmod +x /var/v2ray/entrypoint.sh

WORKDIR /var/v2ray/

ENTRYPOINT ["./entrypoint.sh"]
