title: 一个基于Node.js的本地快速测试服务器
author: Ming ming
tags:
  - npm
  - 包
  - 开源
categories:
  - 开源
  - npm
date: 2018-08-17 09:49:00
---
# local-web-test
![local-web-test](https://img.shields.io/badge/local--web--test-1.0.0-green.svg)
一个本地的基于node.js的测试服务器
支持快速的启动web容器服务
支持快速的发送get，post请求，并记录在/log文件夹下，并在控制台输出
支持一个函数完成cors跨域请求

## Install
```
npm install --save local-web-test
```

## Usage

### 创建本地静态服务器
第一个参数为静态文件地址，第二个参数为端口号
eg;
```
var test = require('local-web-test');
test.static('./', 3344);
```

### 创建get请求
get请求打印在控制台,并写入文件./log/data.js
第一个参数为url，第二个参数为端口号
eg;
```
var test = require('local-web-test');
test.get('./', 3344);
```

### 创建post请求
将post请求打印
第一个参数为post地址，第二个参数为端口号,将会把读取的JSON数据输出在控制台，并写入文件中，文件路径为 ./log/data.json
eg
```
var test = require('local-web-test');
test.post('./', 3344);
```

### Cors
#### 创建get Cors请求
get请求打印在控制台,并写入文件./log/data.js
第一个参数为get地址，第二个参数为端口号,将会把读取的JSON数据输出在控制台，并写入文件中，文件路径为log/data.json, 第三个参数为cors域名,默认支持发送cookice
eg:
```
var test = require('local-web-test');
test.getCors('./', 3344, '*');
```
### 创建post请求
将post请求打印
第一个参数为post地址，第二个参数为端口号,将会把读取的JSON数据输出在控制台，并写入文件中，文件路径为 ./log/data.json，第三个参数为cors域名
eg
```
var test = require('local-web-test');
test.post('./', 3344, '*');
```

# 更新记录
2018年08月17日 1.0.0 
2018年08月17日 1.0.1	增加英文文档（虽然是机翻的，并没有什么用处╮(╯▽╰)╭）

# 依赖
该包依赖于body-parser cookie-parser express multer

# 鸣谢
没有人╮(╯▽╰)╭

# 包地址
https://www.npmjs.com/package/local-web-test

# github
https://github.com/mySoul8012/local-web-test