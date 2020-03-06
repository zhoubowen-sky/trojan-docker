# Trojan-docker
An alpine-based docker image with trojan for crossing the GFW.

## Step for usage
- 1、Prepare a cloud server with CentOS7 for building proxy services.(vultr, do or bwh...)
- 2、Configure your parameter file 'config.json' and place it in the /config directory
- 3、Install Docker<br>
  `yum -y update`<br>
  `yum install -y yum-utils device-mapper-persistent-data lvm2`<br>
  `yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo`<br>
  `yum -y install docker-ce`<br>
  `systemctl start docker`<br>
  `systemctl enable docker`<br>
- 4、Pull this image<br>
   `docker pull zhoubowen123/trojan-docker`
- 5、Create a container<br>
  `docker run --privileged --restart=always -tid -p 443:443/udp -p 443:443/tcp -v /config:/config zhoubowen123/trojan-docker /sbin/init`<br>
  
- 6、Emmmmm...<br>
  Now the server is finished. You can access Google through ss, ssr or brook clients, here are parameters for these clients.

## 相关端口使用情况

应用名称 | 所用端口
:-: | :-:
trojan | 443
http | 80

## References
- 1、https://github.com/trojan-gfw/trojan