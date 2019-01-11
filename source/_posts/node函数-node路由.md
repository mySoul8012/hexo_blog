title: node函数 node路由
author: Ming ming
tags:
  - node函数
  - node路由
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-26 04:29:00
---
# node函数
js中一个函数可以作为另一个函数的参数，即先定义一个函数，然后传递
## 匿名函数
这个学过，过
# node路由
要为路由提供请求的url，和其他需要的get的post请求。
随后，路由会根据需要进行执行响应的代码。
因此，需要根据http请求，从中提取中需要的url和get和post参数
## 两个模块，url和qureystring模块
```
http://localhost:8888/start?foo=bar&hello=word

这个url中
url.parse(string).pathname   start
url.parse(string).query	参数部分即问号后面的内容

querystring.parse(queryString)['foo']	bar内容
querystring.parse(queryString)['hello']  word内容
```
这是说明
## 提取url
```
var http = require('http');
var url = require('url');

(function start() {	// 创建一个命名空间
	function onRequest(request, response) {
		var pathname = url.parse(request.url).pathname;	// 提取出来url的内容
		console.log(pathname);
		response.writeHead(200, {'Content-Type': 'text/plain'});
		response.write('hello word');
		response.end();
	};

	http.createServer(onRequest).listen(1937);
}());

```
访问连接 http://127.0.0.1:1937/hello%20word.html
http://127.0.0.1:1937/hello%20word
返回消息
```
PS C:\Users\mingm\Desktop\test> node main.js
/hello%20word
/favicon.ico
/hello%20word.html
/favicon.ico
```
两个请求，一个是hello word的请求，由于url不支持空格，所以用%20进行替代，node返回客户端请求的是hello word
favicon.ico是浏览器默认的一个请求，若没有图标文件的缓存都会对服务器请求一个图标文件
## 编写一个路由
```
PS C:\Users\mingm\Desktop\test> node index.js
Server has started.
hello word!
hello word!
```
文件结构
```
- test
    router.js
    server.js
    index.js
```
文件内容
```
// router.js
function route(pathname) {
	console.log("hello word!");
};

exports.route = route; // 导出方法


// server.js
var http = require('http');
var url = require('url');

function start(route) {
	function onRequest(request, response) {
		var pathname = url.parse(request.url).pathname;

		route(pathname);	// 使用route的js模块（已经在router.js文件导出）传入的参数的值为pathname
		
		response.writeHead(200, {'Content-Type': 'text/html'});
		response.write('<head><meta charset="utf-8"></head>');
		response.write('Hello word! hello word!');
		response.end();
	};

	http.createServer(onRequest).listen(1937);
  	console.log("Server has started.");
};

exports.start = start;



// index.js
var server = require('./server');
var router = require('./router');

server.start(router.route);
```
访问结果
```
http://127.0.0.1:1937/
Hello word! hello word!
```
