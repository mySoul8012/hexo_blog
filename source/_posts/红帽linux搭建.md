title: 红帽linux搭建
author: Ming ming
tags: []
categories:
  - 后端
  - Linux
  - ''
  - 红帽linux
date: 2018-09-22 00:05:00
---
搭建red hat linux 
目前要学习linux使用的是红帽的linux
> 之前有过一点点的centos基础，一点点的基础


# 下载linux
登录官网 https://www.redhat.com/en
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/21/1.png)
进行注册账号，成为红帽开发者
## 注册成为红帽开发者
访问 https://developers.redhat.com/products/rhel/download/
点击下载，下载红帽linux
或者访问 https://access.redhat.com/downloads/content/69/ver=/rhel---7/7.6%20Beta/x86_64/product-software 
进行下载。
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/21/2.png)
> 图截错了，下载第二个，第一个为引导，不包含软件。需要使用源。

# 下载虚拟机
一般是用vmware 不过习惯上用virtualbox，习惯问题。╮(╯▽╰)╭

> 只不过都是软件木有什么区别。

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/21/3.png)

新建完后启动虚拟机
选择盘符
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/21/4.png)

选择安装linux
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/21/5.png)

选择中文
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/21/6.png)

# 安装设置
设置语言，完成以后设置网络
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/21/7.png)

设置root密码，并设置管理员账户
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/21/8.png)

接着重启，同意许可证，完成安装
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/21/9.png)

# 设置远程连接
由于开虚拟机不舒服，个人习惯，所以使用远程连接linux，理由很简单，一台电脑外加虚拟机没法玩了，太卡了，所以直接设置远程。额。其实并没有什么卵用

> 当前虚拟机使用的网络环境为NAT，查看当前的红帽linux的ip地址





# 阿里云安装red hat
手里目前有阿里云和腾讯云，由于腾讯云目前运行着小站。所以只有阿里云空闲，供自己折腾。所以折腾阿里云，这个难度很低，很简单。额
## 上传镜像到oss
创建镜像，将进行上传到oss
https://oss.console.aliyun.com/bucket/oss-cn-beijing

## 然后进行安装
灰常简单，不在多说。

> 日后学linux，决定使用鸟哥的私房菜，嗯嗯，至少要达到会装lnmp，会进行配置lnmp，，docker也要会配置，git也要会搭，shell也要会写，python自动化脚本也要会写，因为至少不想在服务器上直接npm，那样也不太好。然后直接使用git传上去，然后自动让它拉到服务器上，是整个docker直接上传，暴露出一个ip和端口，然后nginx做转发，目前这个小博客，还要继续改，至少要去掉宝塔，用宝塔的确有点丢人，感觉自己有点丢人。无奈。多余经历玩玩蓝鲸智云，还有z开头的那个监控软件。除此之外开发，学不下去。╮(╯▽╰)╭

现在非常无语，极度的郁闷。我一定是个非科班出身的。目前这个博客必须改。这样太丢人了。毫无精神。