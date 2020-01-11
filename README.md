# docker-v2ray-print

将 v2ray 的配置信息转为 vmess 链接和二维码

[![Deploy To GitHub Registry](https://github.com/CS-Tao/docker-v2ray-print/workflows/Deploy%20To%20GitHub%20Registry/badge.svg)](https://github.com/CS-Tao/docker-v2ray-print/packages/101776?version=master)
[![Deploy To Docker Hub](https://github.com/CS-Tao/docker-v2ray-print/workflows/Deploy%20To%20Docker%20Hub/badge.svg)](https://hub.docker.com/r/cstao/docker-v2ray-print)

## 使用方法

```bash
sudo docker run -d --rm \
  --name v2ray-print \
  -v ./config.json:/var/v2ray/info/config.json:ro
  -v ./print/:/var/v2ray/info/print
  docker.pkg.github.com/cs-tao/docker-v2ray-print/docker-v2ray-print:master
```

## 运行参数说明

和 [vmess2json](https://github.com/boypt/vmess2json/wiki/json2vmess) 一致
