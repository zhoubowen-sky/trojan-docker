# Trojan-docker
An alpine-based docker image with shadowsocks + kcptun, brook trojan and shadowsocksr for crossing the GFW.

## Step for usage
- 1、Prepare a cloud server with CentOS7 for building proxy services.(vultr, do or bwh...)
- 2、Install Docker<br>
  `yum -y update`<br>
  `yum install -y yum-utils device-mapper-persistent-data lvm2`<br>
  `yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo`<br>
  `yum -y install docker-ce`<br>
  `systemctl start docker`<br>
  `systemctl enable docker`<br>
- 3、Pull this image<br>
   `docker pull zhoubowen123/shadowsocks-kcptun`
- 4、Create a container<br>
  `docker run --privileged --restart=always -tid -p 443:443/udp -p 443:443/tcp -p 4000:4000/udp -p 4000:4000/tcp zhoubowen123/shadowsocks-kcptun /sbin/init`<br>
  
- 5、Emmmmm...<br>
  Now the server is finished. You can access Google through ss, ssr or brook clients, here are parameters for these clients.

## Default parameters for client
### Trojan
TROJAN参数名 | 参数取值
-: | :-
服务器地址(ip) | 代理服务器IP
端口(port) | 443
密码(passwd) | qazwsxedc

## 相关端口使用情况

应用名称 | 所用端口
:-: | :-:
trojan | 443
http | 80

## References
- 1、https://github.com/trojan-gfw/trojan