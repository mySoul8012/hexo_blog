title: webpack基础
author: Ming ming
tags: []
categories:
  - 前端
  - 前端自动化
  - webpack
date: 2018-10-17 00:16:00
---
webpack-基础
貌似这些属于编译原理的内容。
当时看了一点编译原理，当中的自动机，彻底懵。
不过大概了解了一点内容。感觉webpack一个打包工具非常类似于一个编译器，将一个文件，转换为另外一个文件。
# 一些概念
## 入口
入口，即寻找入口文件的及其依赖项的文件。即编译前的文件
配置文件为webpack.config.js中修改为
```
module.exports = { 
  entry: "./app.js"
}
```
使用这个可以设置入口文件为./app.js由该文件，可以寻找相关的依赖
## 出口
output告诉要生成那些文件
```
const path = require("path");

module.exports = { 
  entry: "./app.js",
  output: {
  	filename: "my-first-webpack.js"
  }
}
```
导出该文件
## loader
loader可以让webpack处理非js文件。
```
  module: {
  	rules: [
  		{test: /\.txt$/, use: 'raw-loader'}	// 再遇到txt文件的时候，需要使用ras-loader进行转换一下 
  	]
  }
```
遇到txt文件的时候，需要使用raw-loader进行转换
> 类似于express中的中间件

raw-loader表示将文件作为字符串进行读取


## 插件
即打包，优化，定义环境中的变量等。
```
  plugins: [
  	new HtmlWebpackPlugin({template: './src/index.html'})
  ]
```
# 入口文件
```
const config = {
	entry: './file.js',	// 定义入口文件
}

module.exports = config;
```
分离应用程序和第三方库
```
const config = {
	entry: {
		app: './src/app.js',
		vendors: './src/vendors.js'
	}
}

module.exports = config;
```
在上方中webpack会根据app和vendors分别创建两个互相没有任何依赖的依赖图，进行打包
在平常中，一个html文档，只使用一个入口文件。
# 出口
如何写出编译后的文件。
```
const config = {
	entry: {
		app: './src/app.js',
		vendors: './src/vendors.js'
	},
	output: {
		filename: 'bundle.js',	// 文件名称
		path: '/home/assets'	// 输出后的绝对路径
	}
}

module.exports = config;
```

```
const config = {
	entry: {
		app: './src/app.js',
		vendors: './src/vendors.js'
	},
	output: {
		filename: '[name].js',	// 文件名称,name为对象名，输出的文件为app.js vendors.js
		path: '/home/assets'	// 输出后的绝对路径
	}
}

module.exports = config;
```

出口，即编译完成后生成的文件
# load
load为代码转换，可以使用这个加载css文件，使用这个将typeScript转为JavaScript 
安装
```
npm install --save-dev ts-loader
```
```
const config = {
	entry: {
		app: './app.js'
	},
	output: {
		filename: '[name].js',	// 文件名称,name为对象名，输出的文件为app.js vendors.js
		path: '/home/assets'	// 输出后的绝对路径
	},
	module: {
		rules: [
			{test: /\.ts$/, use: 'ts-loader'}
		]
	}
}

module.exports = config;
```
使用这个可以在打包的时候，将ts文件转为js文件。
# 插件
创建同名的js文件
这里的是apply()函数。
```
const pluginName = "ConsoleLogOnBuildWebpackPlugin"

class ConsoleLogOnBuildWebpackPlugin {
	apply(){
		console.log('构建开始');
	}
}
```
使用插件
```
const webpack = require('webpack');	// 访问内置插件

const config = {
	entry: {
		app: './app.js'
	},
	output: {
		filename: '[name].js',	// 文件名称,name为对象名，输出的文件为app.js vendors.js
		path: '/home/assets'	// 输出后的绝对路径
	},
	module: {
		rules: [
			{test: /\.ts$/, use: 'ts-loader'}
		]
	},
	plugins: [
		new webpack.optimize.UgifyJsPlugin(),
		new ConsoleLogOnBuildWebpackPlugin()
	]
}

module.exports = config;
```
