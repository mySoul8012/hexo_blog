title: node.js 模块 hello word程序
author: Ming ming
tags:
  - node.js
  - 模块
  - hello word
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-24 03:21:00
---
node.js（最浅显的，不准备深学啦，入门）
关键，js文档
https://nodejs.org/api/fs.html
包括社区 
https://cnodejs.org/
# 创建hello word程序
## 引入required 模块，并创建服务器
```
var http = require("http");

http.createServer(function(request, response){
	// 发送http
	response.writeHead(200, {'Content-type': 'text/plain'});

	// 发送响应数据
	response.end("hello word\n");
}).listen(8080);
```
文件如上方
## 打开pollshell，执行node命令
```
PS C:\Users\mingm\Desktop\test> node test1.js
```
## 浏览器访问
<img src="https://www.iming.info/images/pasted-1.png">
完成hello word程序
# npm
## npm安装
```
npm install name
```
可选参数为-g，表示是否全局安装
## package.json文件
每个包都有该文件，该文件表示包的基本信息
## 使用npm init命令进行生成配置文件
```
{
  "name": "mingming",
  "version": "1.0.0",
  "description": "这是描述",
  "main": "test1.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}

```
## 一个常用的命令
```
npm update name
```
加上
```
-g
```
表示全局
## npm
https://www.npmjs.com/
## 举例，下载一个redux
### 进官网
https://redux.js.org/
### 找到包，创建该目录，在该目录下打开pollshell
```
npm install --save redux
```

安装，redux插件
好啦，包安装成功
## 模块
将代码合理的拆分到不同的js文件中，每一个文件都是一个模块，文件的路径即为模块名
且后缀名可省
### require
```
var fs = require("fs");
```
读取当前目录的fs.text文件，将变量指向fs.text文件
### exprots
```
> fs.exprots = function(){console.log(333)};
[Function]
>
```
完成导出

### modle访问到当前模块的一些相关信息

```
> module
Module {
  id: '<repl>',
  exports: {},
  parent: undefined,
  filename: null,
  loaded: false,
  children: [],
  paths:
   [ 'C:\\Users\\mingm\\Desktop\\test\\repl\\node_modules',
     'C:\\Users\\mingm\\Desktop\\test\\node_modules',
     'C:\\Users\\mingm\\Desktop\\node_modules',
     'C:\\Users\\mingm\\node_modules',
     'C:\\Users\\node_modules',
     'C:\\node_modules',
     'C:\\Users\\mingm\\.node_modules',
     'C:\\Users\\mingm\\.node_libraries',
     'C:\\Program Files\\nodejs\\lib\\node' ] }
```
### 模块初始化
一个模块中的js代码，仅在模块第一次被使用的时候执行一次，并且在执行的过程中初始化模块导出其对象，之后，缓存起来的导出的对象会被再次重复利用
### 主模块
通过命令行参数，传递给node.js以启动程序的模块称为主模块，主模块负责调度组成整个程序的其他模块完成工作
>　ps，这里的概念，应该是借用了C的主函数

#### 启动主模块
```
node input.js
```
#### 主模块程序示例
##### 目录结构
```
- home/
    - util
        counter.js
    main.js
```
##### main.js
```
/*
 *	这是主模块，通过主模块读取其他模块的内容
 */

var counter1 = require('./util/counter');   读取该文件
var    counter2 = require('./util/counter');

console.log(counter1.count());
console.log(counter2.count());
console.log(counter2.count());
```
##### counter.js
```
var i = 0;

function count() {
    return ++i;
}

exports.count = count;  // 这一句是将其属性添加到调用这个文件的对象上
```
### 启动终端
```
PS C:\Users\mingm\Desktop\test> node main.js
1
2
3
PS C:\Users\mingm\Desktop\test>
```
这里有个需要注意的，因为读入文件，并没有导致被初始化两次，因为读入文件后，将该文件放入缓存，然后由指针进行读取，由于缓存为相同的，所以并没有初始化两次，因为是从同一个缓存区读的
### 二进制模块
node.js支持使用C/C++ 编写二进制模块，编写好的二进制模块的扩展名为node，和js类似
### 小结
node为js的脚本解析器，node.js使用cmd模块系统，主程序为模块的入口点，所有模块在执行过程中只读入缓存区一次，不会进行多次初始化，js模块支持二进制