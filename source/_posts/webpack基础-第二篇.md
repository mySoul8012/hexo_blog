title: webpack基础 第二篇
author: Ming ming
tags: []
categories:
  - 前端
  - 前端自动化
  - webpack
date: 2018-10-18 00:22:00
---
webpack基础 第二篇
webpack能导出一个JavaScript对象。
# CommonJS
webpack使用的是CommonJS模块，即模块化。
通过多个文件进行导入和导出。例如
```
require(....)   // 导入一个模块
import // 导入一个模块
const fs = require('fs');   // 导入fs模块
```
# 一个最基本的配置文件的书写
> 关于  process.env.NODE_ENV ，是用来区分生产环境和开发环境的

```
process.end.NODE_ENV = "dev";   // 设置为开发环境
process.end.NODE_ENV = "prod";  // 设置为生产环境
```
即在开发的时候，进入开发环境，上线的时候，设置为生产环境。

## 一个配置文件的示例
```
const path = require('path');	// 导入path模块

const config = {
	mode: 'development',	// 设置为开发环境
	entry: "./foo.js"	// 入口文件
	output: {
		path: path.resolve(__dirname, 'dist');	// 调用path模块导出的resolve方法
		filename: 'foo.bundle.js'	// 导出的文件为
	}
}
```
设置为开发环境，然后设置入口文件，生成相关的依赖图，然后导出压缩后的文件为foo.bundle.js

# 模块化编程
一种基于接口的编程。（提供接口）
结构化编程，使用大量的结构控制流，来进行块结构，提高程序的清晰度
面向对象编程，经典的Java（基于类进行继承）js（基于原型链进行继承）

# webpack 模块
webpack模块，使用以下的一些内容做为依赖关系。
es5 的import  https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/import
样式表中的url 和html文件的img src

## 支持哪些模块
支持ts，sass， less，

# 模块解析
一个模块可以作为另外一个模块的依赖模块，进行相互依赖。
```
import foo from './path/to/module'
```
使用import导入到foo命名空间，导入的js文件为'./path/to/module'

# 依赖图
一个文件依赖另外一个文件，称为有依赖关系。
> 处理依赖使用的是递归进行处理，先递归，后递推

# 构建目标
使用构建目标，可以加载选择node.js环境还是客户端的环境
```
const path = require('path');	// 导入path模块

const config = {
	target: 'node',
	mode: 'development',	// 设置为生产环境
	entry: "./foo.js"	// 入口文件
	output: {
		path: path.resolve(__dirname, 'dist');	// 调用path模块导出的resolve方法
		filename: 'foo.bundle.js'	// 导出的文件为
	}
}
```
设置target将会生成node.js的运行环境。如果设置
```
web
```
将会生成适应于浏览器端的使用。

# 多个构建的目标
```
let path = require('path');
let serverConfig = {
	target: 'node',
	output: {
		path:path.resolve(__dirname, 'dist');
		filename: 'lib.node.js'
	}
}

let clientCong = {
	target: 'web',
	output: {
		path:path.resolve(__dirname,'dist');
		filename:'lib.js'
	}
}
module.exports = {serverConfig, clientCong}
```
构建多个构建的目标，即一个node环境运行，一个web环境运行。

# 模块的热替换
将会在用户访问的时候，进行访问资源的请求，然后异步更新模块，等到更新完毕以后，通知进行加载，这个过程同步

# 安装
webpack安装，使用npm的方式进行安装。
> 安装，推荐本地安装，如果全局安装会出现很多莫名其妙的问题。

```
npm install --save-dev webpack
```
自动保存进依赖文件中
继续，需要安装命令行工具
```
npm install --save-dev webpack-cli
```
接着，设置包为私有，防止意外发布包
