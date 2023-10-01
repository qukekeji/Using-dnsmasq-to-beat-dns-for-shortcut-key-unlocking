解锁流媒体大家都知道，无论是自己搭建还是付费购买dns解锁服务，都习惯直接修改vps上的dns。看似没有问题，但实则埋藏着隐患。修改了dns意味着你放弃了8.8.8.8、1.1.1.1等这些大厂稳定可靠的dns服务，为了解锁流媒体转而选择小商家自建的dns。dns解锁仍属于小众服务，商家必然不会大力气维护，频繁更换ip，月抛机解锁等操作太常见了，而我们就会遇到因为dns问题无法打开网页的问题。
这里就又要用到dnsmasq来dns“分流”实现选择性解锁。当我们访问netflix、hbo、disney等需要dns解锁的流媒体网站，我们走商家提供的dns；当访问其他网站，我们选择走8.8.8.8、114.114.114.114这类dns。这样不仅能提高dns解析速度，还能减少商家dns不稳定带来的影响。当商家dns不稳定，只会打不开netflix、hbo、disney，并不会影响其他网站正常访问。

安装dnsmasq
CentOS

yum install -y dnsmasq
Ubuntu/Debian

apt-get install -y dnsmasq
配置dnsmasq
清空配置文件dnsmasq.conf，或者将其备份。

# 清空命令
echo "" > /etc/dnsmasq.conf
# 备份命令
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
开始重写配置

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
server=hbonow.com/dns解锁ip
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
将配置文件中的dns解锁ip修改为服务商提供给你的dns的ip。上面的网站只有Netflix、HBO和Disney的，需要解锁更多网站，只需要按照格式把网站域名放进来。网站的域名可以参考：
domain-list-community

vi和vim在命令模式下，使用 :1,$s/dns解锁ip/ip，就能一键将“dns解锁ip”替换为“ip”。不要整文复制后傻傻的一个一个手动修改了。当dns的ip改动后，只需要 :1,$s/旧ip/新ip 就可以了。
配置后不要忘了重启dnsmasq。

service dnsmasq restart
使用dnsmasq
我们把系统的resolv.conf文件修改为127.0.0.1即可，系统会自动使用dnsmasq提供的dns。

vi /etc/resolv.conf
# 只留这么一行
nameserver 127.0.0.1
特定软件
这里的特定软件指的是可以指定/自带dns的软件和服务。像ssr和v2ray是可以指定dns的。那么我们就不需要修改系统resolv.conf文件，尽可能不要动系统文件。
v2ray配置文件中有一大项叫dns，我们将其配置为127.0.0.1即可。具体配置参考官方教程：
v2fly.org/config/dns.html#dnsobject

ssr在其目录下新增文件，名为dns.conf,然后添加内容 127.0.0.1。ssr服务就会使用dns.conf文件里指定的dns进行解析。
