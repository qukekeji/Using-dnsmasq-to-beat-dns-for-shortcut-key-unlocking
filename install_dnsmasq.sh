#!/bin/bash

# 检查是否具有root权限
if [[ $EUID -ne 0 ]]; then
    echo "请以root权限运行此脚本"
    exit 1
fi

# 安装dnsmasq（适用于Ubuntu/Debian）
if command -v apt-get &> /dev/null; then
    apt-get install -y dnsmasq
else
    echo "不支持的操作系统"
    exit 1
fi

# 备份和配置dnsmasq
if [[ -e /etc/dnsmasq.conf ]]; then
    mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
fi

# 写入新的配置
cat <<EOL > /etc/dnsmasq.conf
no-resolv
all-servers
# 以下网站走dns解锁
server=/netflix.ca/dns解锁ip
server=/netflix.com/dns解锁ip
server=/netflix.net/dns解锁ip
server=/netflixinvestor.com/dns解锁ip
server=/netflixtechblog.com/dns解锁ip
server=/nflxext.com/dns解锁ip
server=/nflximg.com/dns解锁ip
server=/nflximg.net/dns解锁ip
server=/nflxsearch.net/dns解锁ip
server=/nflxso.net/dns解锁ip
server=/nflxvideo.net/dns解锁ip
server=/cinemax.com/dns解锁ip
server=/forthethrone.com/dns解锁ip
server=/hbo.com/dns解锁ip
server=/hboasia.com/dns解锁ip
server=/hbogo.com/dns解锁ip
server=/hbogoasia.com/dns解锁ip
server=/hbogoasia.hk/dns解锁ip
server=/hbomax.com/dns解锁ip
server=/hbonow.com/dns解锁ip
server=/maxgo.com/dns解锁ip
server=/disney.com/dns解锁ip
server=/disneyjunior.com/dns解锁ip
server=/disneyplus.com/dns解锁ip
server=/bamgrid.com/dns解锁ip
# 默认走如下dns
server=8.8.8.8
server=1.1.1.1
cache-size=2048
local-ttl=60
listen-address=127.0.0.1
EOL

# 重启dnsmasq
service dnsmasq restart

# 修改系统的resolv.conf文件
echo "nameserver 127.0.0.1" > /etc/resolv.conf

echo "dnsmasq已安装并配置完成"
