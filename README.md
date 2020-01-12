# docker-v2ray-print

将 v2ray 的配置信息转为 vmess 链接和二维码

[![Deploy To GitHub Registry](https://github.com/CS-Tao/docker-v2ray-print/workflows/Deploy%20To%20GitHub%20Registry/badge.svg)](https://github.com/CS-Tao/docker-v2ray-print/packages/101776?version=master)
[![Deploy To Docker Hub](https://github.com/CS-Tao/docker-v2ray-print/workflows/Deploy%20To%20Docker%20Hub/badge.svg)](https://hub.docker.com/r/cstao/docker-v2ray-print)

## 使用方法

```bash
sudo docker run -d --rm \
  --name v2ray-print \
  -v ./print/:/var/v2ray/volume \
  docker.pkg.github.com/cs-tao/docker-v2ray-print/docker-v2ray-print:master
```
*提示：此处使用的是 GitHub Docker Registry 的镜像，也可以使用 Docker Hub 的镜像 [cstao/docker-v2ray-print](https://hub.docker.com/r/cstao/docker-v2ray-print)，下面均以 Docker Hub 的镜像为例*

容器运行时会打印链接和二维码到容器的日志中，在容器运行完成后也会将链接和二维码保存到`/var/v2ray/volume/output.txt`中，将此文件挂载（volume）到主机上便可以通过`cat output.txt`命令脱离容器查看输出

## 如何传入 config.json

通过指定 volume，将 `config.json` 挂载到`/var/v2ray/volume/`文件夹下

## 容器运行参数（可选）

和 [vmess2json](https://github.com/boypt/vmess2json/wiki/json2vmess) 大致相同，但原文档的**有误**，此处有所更改

### 用法

下方使用`printer`代指`docker run -d -v ./folder_of_config/:/var/v2ray/volume cstao/docker-v2ray-print`

```bash
usage: printer [-a ADDR] [-f FILTER] [-m AMEND] [--debug]

optional arguments:

  -a ADDR, --addr ADDR  server address. If not specified, program will detect
                        the current IP
  -f FILTER, --filter FILTER
                        Protocol Filter, useful for inbounds with different
                        protocols. FILTER starts with ! means negative
                        selection. Multiple filter is accepted.
  -m AMEND, --amend AMEND
                        Amend to the output values, can be use multiple times.
                        eg: -m port:80 -m ps:amended
  --debug               debug mode, show vmess obj
```

### 示例

下方使用`printer`代指`docker run -d -v ./folder_of_config/:/var/v2ray/volume cstao/docker-v2ray-print`

```bash
#just list the links and qrcode (on server)
printer

# if using h2/ws protocols, auto detected IP is not working, manually specify it
printer --addr my.v2ray.domain.net

# json file has multiple inbounds with different protocols
# output those ws and h2 and replace to port 443 for the caddy/nginx is proxying the websocket at 443
printer --addr my.v2ray.domain.net --filter ws --amend port:443 --debug

# use raw IP address for kcp and tcp connections 
printer --addr 2001:1234:5678::9999 --filter kcp -f tcp --debug

# or just any protocols other than websocket
printer --addr 2001:1234:5678::9999 --filter \!ws --debug
```
