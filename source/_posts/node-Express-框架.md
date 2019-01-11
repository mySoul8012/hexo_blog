title: node Express 框架
author: Ming ming
tags:
  - node.js
  - Express框架
categories:
  - 前端
  - js
  - 服务器端js
  - 框架
  - Express
date: 2018-07-29 21:56:00
---
哈。github的地址已经更换，求start
https://github.com/mySoul8012

继续~
Express框架
# 简单介绍一下
Express事实上Node内置的http模块上构建的一层抽象。理论上所有Express实现的功能都能用Node实现
核心特征;
1. 设置中间件响应http请求
2. 定义路由表，执行不同的http请求
3. 先模板传递参数，来动态的渲染html文件

## 一些网址
npm的Express https://www.npmjs.com/package/express
项目地址 https://github.com/expressjs/express
网址和文档 http://expressjs.com/
翻译的中文文档 http://expressjs.com/zh-cn/
## 安装Express
使用npm安装，并将其保存进入依赖列表中
由于一堵高不可攀的墙大人的问题，所以呢，被迫使用cnpm，使用来自淘宝的镜像，由淘宝完成镜像的同步
节省一点点宝贵的时间\(^o^)/
> 全新安装的需要安装淘宝的镜像 https://npm.taobao.org/ 使用cnpm代替npm完成安装

> -save 的意思为自动更新依赖文件，依赖文件为package.json

```
PS C:\Users\mingm\Desktop\test\Express> cnpm install express --save
√ Installed 1 packages
√ Linked 46 latest versions
√ Run 0 scripts
Recently updated (since 2018-07-21): 1 packages (detail see file C:\Users\mingm\Desktop\test\Express\node_modules\.recently_updates.txt)
√ All packages installed (51 packages installed from npm registry, used 3s(network 3s), speed 291.62kB/s, json 47(354.74kB), tarball 535kB)
PS C:\Users\mingm\Desktop\test\Express>
```
查看依赖pacage.json文件
```
{
  "dependencies": {
    "express": "^4.16.3"
  }
}

```
可以看到依赖的是express的4.16.3版本

查看一下目录
```
PS C:\Users\mingm\Desktop\test\Express> ls


    目录: C:\Users\mingm\Desktop\test\Express


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        2018/7/28     18:35                node_modules
-a----        2018/7/28     18:35             53 package.json


PS C:\Users\mingm\Desktop\test\Express>
```
可以查看到有一个node_modules目录，该目录保存的是npm包
### 一些还需要安装的模块
body-parser 一个node的中间件 用于处理JSON，等和URL的编码的处理
https://www.npmjs.com/package/body-parser
文档以及项目地址 https://github.com/expressjs/body-parser
cookie-parser 一个负责解析Cookie的工具可以将传过来的Cookie将其转换为对象
https://www.npmjs.com/package/cookie-parser
multer node.js的中间件 处理表单数据
项目地址 https://github.com/expressjs/multer
npm https://www.npmjs.com/package/multer
自诉文件 https://github.com/expressjs/multer/blob/master/doc/README-zh-cn.md
原版的自述文件 https://github.com/expressjs/multer/blob/master/README.md
好啦。一共是一块安装了3个模块
继续使用淘宝源
```
PS C:\Users\mingm\Desktop\test\Express> cnpm install body-parser --save
√ Installed 1 packages
√ Linked 0 latest versions
√ Run 0 scripts
√ All packages installed (used 248ms(network 242ms), speed 23.48kB/s, json 1(5.68kB), tarball 0B)
PS C:\Users\mingm\Desktop\test\Express> cnpm install cookie-parser --save
√ Installed 1 packages
√ Linked 0 latest versions
√ Run 0 scripts
√ All packages installed (used 264ms(network 258ms), speed 4.99kB/s, json 1(1.29kB), tarball 0B)
PS C:\Users\mingm\Desktop\test\Express> cnpm install multer --save
√ Installed 1 packages
√ Linked 21 latest versions
√ Run 0 scripts
√ All packages installed (22 packages installed from npm registry, used 1s(network 1s), speed 307.56kB/s, json 22(92.57kB), tarball 343.86kB)
PS C:\Users\mingm\Desktop\test\Express>
```
完成三个模块的安装
查看一下依赖文件
```
{
  "dependencies": {
    "body-parser": "^1.18.3",
    "cookie-parser": "^1.4.3",
    "express": "^4.16.3",
    "multer": "^1.3.1"
  }
}

```
依赖四个模块
# 创建一个框架实例
输出hello world！
```
// app.js文件
var express = require('express');
var app = express();

app.get('/', (req, res) => {
	res.send('hello world!');
});

var server = app.listen(1938, () => {
	var host = server.address().address;
	var port = server.address().port;

	console.log('%s:%s', host, port);
})
```
```
PS C:\Users\mingm\Desktop\index\Express> node app.js
:::1938
```
此程序会监听1938上的连接，当有连接传入的时候，应用程序会以hello world!进行响应，然后将其返回。
# 路由
路由决定了由谁响应http请求，通过提取GET和POST请求的参数，下面继续扩展程序
```
PS C:\Users\mingm\Desktop\index\Express> node app.js
{ address: '::', family: 'IPv6', port: 1937 }
```
```
var express = require('express');
var app = express();

// 输出hello world
app.get('/', (req, res) => {
	console.log('输出对于主页的GET请求');
	res.send('Hello GET!');
});

// post请求
app.post('/', (req, res) => {
	console.log('主页post请求');
	res.send('Hello POST');
});

// 对于/del_user的页面响应
app.get('/del_user', (req, res) => {
	console.log('这是对于页面 /del_user页面的响应');
	res.send("Hello del_user");
	res.send("你好哈！ 这里已经将页面进行删除");
});

// /list_user 页面的GET请求
app.get('/list_user', (req, res) => {
	console.log('这里是对 /list_user页面的请求');
	res.send('Hello list_user');
});

// /对页面abcd abcdxcd ab123cd 的请求进去正则
app.get('ab*cd', (req, res) => {
	console.log('进行了正则');
	res.send('hello 正则！');
});

// 启动http服务器
var server = app.listen(1937, () => {
	console.log(server.address());
});
```

访问 http://127.0.0.1:1937/del_user
返回 Hello del_user
好啦！\(^o^)/
# 解析静态文件
Express使用了中间件 express.static中间件设置静态文件
> 事实上是一个http服务器外加一个fs模块完成封装的

目录结构如下
```
- Express  // 站点文件
    - image // 图片文件夹
        1.gif   // 将要访问的静态资源
    + node_modules  // npm包所在文件夹
    app.js      // 入口文件
    package.json    // 配置文件
```
代码如下
```
PS C:\Users\mingm\Desktop\index\Express> node app.js
{ address: '::', family: 'IPv6', port: 1937 }

```
```
var express = require('express');
var app = express();

app.use(express.static('./image'));		// 使用中间件 express.static 设置的静态资源文件夹为image

app.get('/', (req, res) => {
	res.send('hello world！');
});

var server = app.listen(1937, () => {
	console.log(server.address());
});
```
访问 http://127.0.0.1:1937/1.gif
出现静态资源，\(^o^)/

# GET方法
> res.sendFile() http://expressjs.com/en/4x/api.html#res.sendFile

> __dirname 获取当前执行文件所在目录的完整目录名
> res.sendFlie（path [，options] [，fn]） path必须为绝对路径，Content-Type 会根据扩展名设置相应的HTTP标头字段，需要注意的是path必须为绝对路径

> __dirname 获取当前执行文件所在目录的完整目录名
> __filename 获取当前执行文件带有完整绝对路径的文件名
> process.cwd() 获取当前执行node命令时候的文件夹的目录名
> ./ 文件所在目录

> req.query 此属性是一个对象，包含路由中每个查询字符串参数的属性。
> 304请求 一个条件请求，如果有缓存的数据则进行请求，否则将不会进行请求

```
<!doctype html>
<html>
<head>
	<title>Hello from</title>
	<meta charset="utf-8">
</head>
<body>
	<form action="/process_get" method="get">
		<label>first_name</label><input type="text" name="first_name"/>
		<label>last_name</label><input type="text" name="last_name"/>
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>
```
```
var express = require('express');
var app = express();

app.use(express.static('public'));	// 加载中间件

app.get('/index.html', (req, res) => {	// 调用中间件指定的静态资源目录 public, 然后调用回调函数
	res.sendFile( __dirname + '/' + 'index.html');	// 输出html文件的绝对路径，采取的是拼接字符串的方式,设置http标头
});

app.get('/process_get', (req, res) => {
	// 输出json格式
	var response = {
		'first_name': req.query.first_name,	// 将http报文中 查询到的first_name的值作为属性值
		'last_name': req.query.last_name	// 同上
	};
	console.log(response); // 输出获取到的json的值
	res.end(JSON.stringify(response));	// 将获取到的值转为JSON格式的值，然后进行返回
});

var server = app.listen(1937, () => {
	console.log(server.address());
});
```
用浏览器查看一下json数据
请求为get 发送的url为 http://127.0.0.1:1937/process_get?first_name=ming&last_name=ming
查询的字符串为
first_name=ming
last_name=ming
总共，请求头为
```
Host: 127.0.0.1:1937
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2
Accept-Encoding: gzip, deflate
Referer: http://127.0.0.1:1937/
Cookie: hibext_instdsigdipv2=1
Connection: keep-alive
Upgrade-Insecure-Requests: 1
```
主机地址为127.0.0.1:1937
user-Agent为本地的系统的一些信息
剩下的有点看不懂。。╮(╯▽╰)╭
由于设置的是直接返回JSON数据，所以查看一下响应头
```
{"first_name":"ming","last_name":"ming"}
```
此为响应载荷
报文为
```
HTTP/1.1 200 OK
X-Powered-By: Express
Date: Sat, 28 Jul 2018 16:39:08 GMT
Connection: keep-alive
Content-Length: 40
```
采用的是http1.1协议，返回的报文为200
同理
DevTol也是如此不在进行阐述
# 下面进行POST请求
> 需要使用一个中间件 body-parser，其简单的文档 https://www.npmjs.com/package/body-parser

> 需要使用一个bodyParser.urlencoded 该对象返回解析urlencoded主体。在返回的body中，将会在req对象上添加一个新的对象，该对象为body。其中的值为字符串和数组，此对象会包含键值对。其中的值可以为字符串和数组（此时设置的extended的值为false），其中的值允许为任何类型的需要设置extended的值为last

```
var express = require('express');
var app = express();
var bodyParser = require('body-parser');	// 加载Express中间件

// 使用中间件提供的bodyParser.urlencoded对来自于post的url进行解析,只允许字符串和数字类型的结果
var urlencodeParser = bodyParser.urlencoded({ extended: false });

app.use(express.static('public'));	// 设置静态资源目录为public

// 进行路由匹配
app.get('/index.html', (req, res) => {
	res.sendFile(__dirname + '/' + 'index.html');	// 路径的拼接,拼接的是当前文件的所在目录的绝对地址，由于要请求静态资源，自动跳到public文件夹下进行返回
});

// post请求的匹配
app.post('/process_post', urlencodeParser, (req, res) => {	// 先进行回调第一个函数，将post请求，使用中间件进行处理，处理完后的值进行返回到req和res即下一个回调函数,数据经过两次回调
	// 输出JSON格式
	var response = {
		'first_name': req.body.first_name,	// 进行键值对的保存
		'last_name': req.body.last_name	
	};
	console.log(response);	// 将接收到的数据进行输出
	res.end(JSON.stringify(response));	// 将键值对保存的对象转化为JSON格式返回给客户端
});

var server = app.listen(1937, () => {	// 开启http服务器
	console.log(server.address());
});
```
```
<!doctype html>
<html>
<head>
	<title>Hello from</title>
	<meta charset="utf-8">
</head>
<body>
	<form action="/process_post" method="POST">
		<label>first_name</label><input type="text" name="first_name"/>
		<label>last_name</label><input type="text" name="last_name"/>
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>
```
ok~
好啦。访问 http://127.0.0.1:1937
顺便打开浏览器开发者工具进行查看返回的JSON数据
```
{"first_name":"ming","last_name":"ming"}
```
♪(^∇^*)完美~

# 文件上传
使用post方法完成文件的上传。
> from 表单的enctype属性当method属性值为post的时候，enctype提交的是from给服务器内容的mime类型，即媒体类型，

> 解释一下form表单的enctype的三个值

> http的post方法，给服务器时，请求主题类型由 Content-Type 指定，通常一个POST请求是通过HTML表单发送的，并返回给服务器返回修改的结果，form表单的enctype属性是设置上传的编码的

> application/x-www-form-urlencoded 数据被编码成为&进行分割的键值对同时以=作为分割的键值对。非字母和数字的字符会被进行百分比编码 解释 https://developer.mozilla.org/zh-CN/docs/Glossary/percent-encoding  

> multipart/form-data 将会以二进制的方式进行上传，上传文件的时候必须按照这个方法进行提交

> text/plain 空格转化为+号，不对其做任何的处理进行提交

> https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Methods/POST

> multer(opts) opts具有一个dest属性，将会告诉Multer中间件上传到服务器的位置。

> multer(opts)接受链式调用.array(fieldname[, maxCount]) 支持一个是否为文件数组

```
/*
var express = require('express');
var app = express();	// 创建框架的类
var fs = require('fs');

var bodyParser = require('body-parser');	// 加载中间件
var multer = require('multer');
var storage = multer.diskStorage({ 
	destination: (req, file, cb) => {
		cb(null, './image')	// 文件上传的目录
	},
	filename: (req, file, cb) => {
		var fileFormat = (file.originalname).split(".");	// 先将文件名采用split按照.进行分裂
		cb(null, file.fieldname + '-' + Date.now() + '.' +  fileFormat[fileFormat.length - 1]);	// 对文件重命名，加上扩展名
	}
});	// 确定一下上传的配置选项


app.use(express.static('public'));	// 添加静态文件，用于处理静态文件，框架自带的
app.use(bodyParser.urlencoded({ extended: false }));	// 用于处理JSON等数据
app.use(multer({storage: storage}).array('image'));

app.get('/index.html', (req, res) => {
	res.sendFile( __dirname + '/' + 'index.html' );	// 对于首页的请求
});

// 该过程中间经历了对静态文件的（static中间件，urlencoded对url的解析，只允许字符串和数字的结果，使用了上传的multer的中间件，最后到回调函数）
app.post('/file_upload', (req, res) => {	// 允许上传多个文件，其中文件数组保存在req.files
	console.log(req.files[0]);	// 上传文件的信息
	 var des_file = __dirname + "/" + req.files[0].originalname;
   fs.readFile( req.files[0].path, function (err, data) {
        fs.writeFile(des_file, data, function (err) {
         if( err ){
              console.log( err );
         }else{
               response = {
                   message:'File uploaded successfully', 
                   filename:req.files[0].originalname
              };
          }
          console.log( response );
          res.end( JSON.stringify( response ) );
       });
   });
});

var server = app.listen(1937, () => {
	console.log(server.address());
});



*/

var express = require('express');
var app = express();
var fs = require("fs");
 
var bodyParser = require('body-parser');
var multer  = require('multer');
 
app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(multer({ dest: '/tmp/'}).array('image'));	// 设置临时上传的地址
 
app.get('/index.htm', function (req, res) {
   res.sendFile( __dirname + "/" + "index.htm" );
})
 
app.post('/file_upload', function (req, res) {
 
   console.log(req.files[0]);  // 上传的文件信息
 
   var fileFormat = (req.files[0].originalname).split(".");
   var fileName = req.files[0].fieldname + '-' + Date.now() + "." + fileFormat[fileFormat.length - 1];
   var des_file = __dirname + "/image/" + fileName;	// 将要上传的地址

	console.log(des_file);
	fs.open( './image/' + fileName, 'a', function(err, fd) {
   if (err) {
       return console.error(err);
   }
  fs.readFile( req.files[0].path, (err, data) => {
	        fs.writeFile(des_file, data, (err) => {
	        console.log(data);
	         if( err ){
	              console.log( err );
	         }else{
	               response = {
	                   message:'File uploaded successfully', 
	                   filename:req.files[0].originalname
	              };
	          }
	          console.log( response );
	          res.end( JSON.stringify( response ) );
	      	 });
   		});    
});

  		
});
 
var server = app.listen(8081, function () {
 
  var host = server.address().address
  var port = server.address().port
 
  console.log("应用实例，访问地址为 http://%s:%s", host, port)
 
})

```
思路，是先将文件以追加的方式打开，然后将通过中间件上传的文件写入追加打开的文件
```
<html>
<head>
	<title>文件上传表单</title>
</head>
<body>
	<h3>文件上传</h3>
	<form action="/file_upload" method="post" enctype="multipart/form-data">
		<input type="file" name="image" size="50">
		<br>
		<input type="submit" value="上传文件">
	</form>
</body>
</html>
```
# Cookie管理
使用中间件发送Cokie信息。
引入cookie-parser
再引入 util模块，将对象转换为字符串
这个很简单。过