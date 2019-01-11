title: node GET 和 POST 请求
author: Ming ming
tags:
  - node.js
  - GET
  - POST
  - 表单
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-27 04:29:00
---
node GET和POST请求
# 获取GET请求内容
util.inspect 返回Object的字符串表示
http://nodejs.cn/api/util.html#util_util_inspect_object_options
url.parse   解析一个url字符串，返回一个url对象
http://nodejs.cn/api/url.html#url_url_parse_urlstring_parsequerystring_slashesdenotehost
```
var http = require('http');
var url = require('url');
var util = require('util');

http.createServer((req, res) => {
	res.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});	// 头部信息
	res.end(util.inspect(url.parse(req.url, true)));	// url.parse 获取url的链接，并生成一个对象（true的含义） util.inspect 将对象转换为字符串
}).listen(1987);
```
```
Url {
  protocol: null,
  slashes: null,
  auth: null,
  host: null,
  port: null,
  hostname: null,
  hash: null,
  search: null,
  query: {},
  pathname: '/',
  path: '/',
  href: '/' }
```
# 获取POST请求
post请求在请求体中
需要使用querystring模块
http://nodejs.cn/api/querystring.html
需要使用一个api
querystring.parse
http://nodejs.cn/api/querystring.html#querystring_querystring_escape_str
一个通过post提交，并输出数据
```
var http = require('http');
var queryString = require('querystring');

// HTML内容
var postHTML = 
	'<html><head><meta charset="utf-8"><title>小ming</title></head>' + 
	'<body>' + 
	'<form method="POST">' +
	'<label>name</label><input name="name" type="text"><br>' +
	'<label>password</label><input name="password" type="password"><br>' +
	'<input type="submit">' +
	'</form>' +
	'</body></html>';

// 创建http服务器
http.createServer((req, res) => {
	var body = '';
	req.on('data', (chunk) => {		// 绑定data事件，将提交的post请求，累加到body内
		body += chunk;
	});
	req.on('end', () => {	// 绑定报文结束部分的事件
		body = queryString.parse(body);		// 将参数进行解析
	// 上方的都为获取的http报文内容即post请求

	// 下方进行返回,即http返回的内容
		res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});	// 设置响应头

		if(body.name && body.password) {	// 输出提交的数据
			res.write('您的用户名' + body.name);
			console.log('输入的用户名' + body.name);
			res.write('<br>');
			res.write('输入的密码为' + body.password);
			console.log('输入的密码' + body.password);
		}
		else {	// 如果输入的内容为空
			res.write(postHTML);	// 直接返回表单
		};
		res.end();	// http内容传输结束
	})
}).listen(1937);
```
```
PS C:\Users\mingm\Desktop\test> node main.js
输入的用户名melovemingming
输入的密码1111
输入的用户名melovemingming
输入的密码1111
```
