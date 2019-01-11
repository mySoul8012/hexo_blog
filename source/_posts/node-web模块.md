title: node web模块 (服务器端和客户端)
author: Ming ming
tags:
  - node.js
  - 服务器端
  - 客户端
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-28 03:01:00
---
node web模块
# web服务器
web服务器指网站服务器，指驻留在因特网上的某种程序，web浏览器的基本功能，提供信息浏览服务
web支持服务器端的脚本语言，通过脚本语言从数据库获取数据，将结果返回给客户端浏览器
# web应用基本架构
```
Client => Server => Business => Data
Client 即客户端，通过http协议向服务器发起请求
Server 服务器端，指web服务器，接收客户端请求，并向客户端发送响应的数据
Business 即业务层，通过Web服务器处理应用程序，数据库的交互，逻辑运算，调用外部程序
Data 数据层，储存数据
```
# 使用Node创建Web服务器
使用http模块创建
> 需要使用substr()方法，一个从指定位置返回指定结束的方法，继承自String 最后一个参数可省 https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/substr


```
// server.js
// 引入模块
var http = require('http');	// http模块
var fs = require('fs');		// fs 文件模块
var url = require('url');	// url 统一资源定位符模块

// 创建服务器
http.createServer((request, response) => {
	// 解析请求，保存进变量内
	var pathname = url.parse(request.url).pathname;

	// 输出请求的文件名
	console.log(pathname);

	// 从文件系统中读取文件，进行返回
	fs.readFile(pathname.substr(1), (err, data) => {	// 使用substr方法进行读取文件的字节，将文件名返回给回调函数
		if (err){	// 对错误进行处理
			console.log(err);	// 打印出错误
			// 返回一个404
			response.writeHead(404, {'Content-Type': 'text/html; charset=utf-8'});
			response.write("呀，什么都没有╮(╯_╰)╭");
			response.write('我猜你要的是&nbsp;' + data + '&nbsp;?');
			response.end();
		} else {
			// 返回 200
			response.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
			// 返回文件内容
			response.write(data.toString());	// 将读取的文件内容进行字符串化，并进行输出
			response.end();	// 关闭连接,发出数据
		};
	});
}).listen(1937);
```
```
// index.html
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>这是一个小Dome</title>
	</head>
	<body>
		<h1>hello word！</h1>
	</body>
</html>
```
访问 http://127.0.0.1:1937/index.html
出现hello word完成！
```
PS C:\Users\mingm\Desktop\test> node Server.js
/index.html
/
/input.html
/
{ [Error: ENOENT: no such file or directory, open 'C:\Users\mingm\Desktop\test\input.html']
  errno: -4058,
  code: 'ENOENT',
  syscall: 'open',
  path: 'C:\\Users\\mingm\\Desktop\\test\\input.html' }

```
## 改进一点
访问/出现404,说明没有设置首页，设置首页
```
	// 增加对首页的支持,设置默认首页为index.html
	if (pathname === '/') {
		pathname = pathname + 'index.html';
	}
```
完成后的文件如下
```
// 引入模块
var http = require('http');	// http模块
var fs = require('fs');		// fs 文件模块
var url = require('url');	// url 统一资源定位符模块

// 创建服务器
http.createServer((request, response) => {
	// 解析请求，保存进变量内
	var pathname = url.parse(request.url).pathname;

	// 输出请求的文件名
	console.log(pathname);

	// 增加对首页的支持,设置默认首页为index.html
	if (pathname === '/') {
		pathname = pathname + 'index.html';
	}

	// 从文件系统中读取文件，进行返回
	fs.readFile(pathname.substr(1), (err, data) => {	// 使用substr方法进行读取文件的字节，将文件名返回给回调函数
		if (err){	// 对错误进行处理
			console.log(err);	// 打印出错误
			// 返回一个404
			response.writeHead(404, {'Content-Type': 'text/html; charset=utf-8'});
			response.write("呀，什么都没有╮(╯_╰)╭");
			response.write('我猜你要的是&nbsp;' + data + '&nbsp;?');
			response.end();
		} else {
			// 返回 200
			response.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
			// 返回文件内容
			response.write(data.toString());	// 将读取的文件内容进行字符串化，并进行输出
			response.end();	// 关闭连接,发出数据
		};
	});
}).listen(1937);
```
# 使用node创建客户端
```
PS C:\Users\mingm\Desktop\test> node get.js
<html>
<head><title>302 Found</title></head>
<body bgcolor="white">
<center><h1>302 Found</h1></center>
<hr><center>nginx</center>
</body>
</html>

PS C:\Users\mingm\Desktop\test>
```
```
var http = require('http');

// 请求的选项
var options = {	// 创建一个对象保存相关数据
	host:'www.iming.info',	// 主机地址
	port:'443',	// 访问端口
	method:'GET',
	path:'/',	// 访问的文件
};

// 处理响应的回调函数
var callback = (response) => {
	// 更新数据
	var body = '';
	response.on('data', (data) => {		// 绑定事件，data
		body += data;	
	});

	response.on('end', () => {	// 绑定end事件
		console.log(body);	
	});
};

// 开始发送请求
var req = http.request(options, callback);	// 发送请求，options为发送请求的选项，callback为处理请求的回调函数，将会有抛出三个事件一个data一个end，一个error，必须有end表示请求完毕，关闭连接
req.end();	// 关闭连接
```
由于小站使用的是nginx的https，使用了证书，需要使用验证秘钥的过程，所以拒绝访问，302没有权限
