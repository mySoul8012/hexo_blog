title: 服务器端的JavaScript
author: Ming ming
tags:
  - js
  - 服务器端
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-23 20:33:00
---

# Rhino
https://developer.mozilla.org/zh-CN/docs/Mozilla/Projects/Rhino
用Java编写的js解释器，设计的目标是借助Javaapi实现编写js程序，该程序能实现js到Java的互相转换
由于Java没有学，所以这个跳过
其学习文档 https://developer.mozilla.org/en-US/docs/Mozilla/Projects/Rhino/Documentation
唉，中文版本翻译不完全，无奈╮(╯▽╰)╭
英语啊，我的大英语。。我要看懂文档！！！
# Node.js
> 意外的发现的一个网站，https://mailchimp.com/ 好的，随便注册，发现网站下由订阅地址，顺带订阅，目前我也不知道我的邮箱里都是些什么垃圾邮件，挺杂的，github的推送，推特的推送，乱七八糟，简直是垃圾集散地，当年做的独立域名建邮箱的策略。真的有先见之明！

注意，以下是非常浅的node.js，学习node.js不是为什么做后端，是因为最基本的npm这个必须会，否则连个脚手架都不会了，连个vue，jQuery都不会下了

## 先准备对本博客改版
### 连接shell，查看当前npm的版本
```
[root@VM_29_131_centos ~]# npm -v
5.6.0
```
### 找到hexo的官方文档
https://hexo.io/zh-cn/docs/
### 找到一个可靠的源
由于某些众所周知的问题，导致npm出现的很大很大的异常。好吧
淘宝有源，安装的时候使用淘宝的源即可，（愤愤不平~┑(￣Д ￣)┍）
（这都是什么事情嘛）
http://npm.taobao.org/
### 出现一个警告
```
npm WARN deprecated socks@1.1.10: If using 2.x branch, please upgrade to at least 2.1.6 to avoid a serious bug with socket data flow and an import issue introduced in 2.1.0
C:\Users\mingm\AppData\Roaming\npm\cnpm -> C:\Users\mingm\AppData\Roaming\npm\node_modules\cnpm\bin\cnpm
+ cnpm@6.0.0
updated 1 package in 32.005s
```
好吧，提示让我升级了
好吧，安装n模块
好吧，出现错误无奈，懒的折腾，直接卸载重安
### 官网下载node.js
https://nodejs.org/en/
好吧，龟速的网络，不在吐槽了。我家还电信网呢，╮(╯▽╰)╭
耽误事情
### 安装
### 继续更换源
```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```
### 安装hexo
```
npm install hexo-cli -g
```
### 创建新用户
```
# useradd -m ming
```
### 添加密码
```
# passwd ming
```
### 赋予权限
先按照vim编辑器
```
yum install -y vim
```
再修改文件
```
vim /etc/sudoers
```
```
/etc/sudoers文件90多行左右修改成如下格式：（:wq!退出）

## Allow root to run any commands anywhere
root    ALL=(ALL)    ALL
ming    ALL=(ALL)    ALL    
```
### 切换用户
```
[root@VM_29_131_centos ~]# su ming
```
### 进入用户目录
```
cd ~
```
### 创建站点文件夹
```
[ming@VM_29_131_centos ~]$ mkdir Codes
[ming@VM_29_131_centos ~]$ cd Codes
[ming@VM_29_131_centos Codes]$ 
```
### 安装服务器端
```
 npm install hexo-server --save

```
### 启动服务器端
```
hexo server
```
### neginx设置反代
### 设置开机启动服务端
#### 新建脚本
centnet-service.sh
#### 输入脚本内容
```
 hexo server
```
#### 设置为可执行文件
```
[root@VM_29_131_centos home]# chmod +x centnet-service.sh
[root@VM_29_131_centos home]# 
```
```
[root@VM_29_131_centos ~]# chmod +x /etc/rc.d/rc.local
[root@VM_29_131_centos ~]# 
```
#### 打开/etc/rc.d/rc.local文件添加如下脚本
```
/home/centnet-service.sh
```
### 接着，安装hexo-admin包
安装详见 https://github.com/jaredly/hexo-admin
### 访问，出现Cannot GET /admin/
查找问题
### 完成
反正也不知道怎么就完成了。。。
# 下面开始学习粗浅的学习的服务器端的node.js。模拟一个get和post请求