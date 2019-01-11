title: ejs koa
author: Ming ming
tags:
  - ejs
  - koa
categories:
  - 前端
  - js
  - 服务器端js
  - node.js
date: 2018-08-26 04:05:00
---
ejs
# 简介
中文官网 https://ejs.bootcss.com/
npm https://www.npmjs.com/package/ejs
github https://github.com/mde/ejs
官网 http://ejs.co/
# 安装
```
 npm install --save ejs
```
下面接着创建package.json
```
npm init
```
# 继续安装koa
网址 https://koa.bootcss.com/
github https://github.com/koajs/koa
官网 https://koajs.com/
npm https://www.npmjs.com/package/koa
```
npm --install --save koa
```
## koa2基础
### 架设http服务器
```
const koa = require('koa');
const app = new koa();

app.listen(3000);
```
输入网址 http://127.0.0.1:3000/  即可完成假设

### 输出hello world
```
const koa = require('koa');
const app = new koa();

const main = ctx => {
	ctx.response.body = "hello world";
}

app.use(main);
app.listen(3000);
```
上方是回调，将会使用main，main进行回调一个匿名函数，完成body的设置。
```
ctx.response
```
代表着一个http的请求
### 不同的请求返回不同的类型
```
const koa = require('koa');
const app = new koa();

const main = ctx => {
	if (ctx.request.accepts('xml')) {
		ctx.response.type = 'xml';
		ctx.response.body = '<data>hello world</data>';
	} else if (ctx.request.accepts('json')) {
		ctx.response.type = 'json';
		ctx.response.body = {'data': 'hello world'};
	} else if (ctx.request.accepst('html')) {
		ctx.response.type = 'html';
		ctx.response.body = '<p>hello world</p>'
	} else {
		ctx.response.type = 'text';
		ctx.response.body = 'hello world';
	}
}

app.use(main);
app.listen(3000);
```
> ps 使用https://www.getpostman.com/ 编辑http请求，发送http请求

即可完成。

### 网页模板
使用fs模块，使用流，将客户端和文件之间建立流的关系，然后将其对接
```
const koa = require('koa');
const fs = require('fs');
const app = new koa();

const main = ctx => {
	ctx.response.type = 'html';
	 ctx.response.body = fs.createReadStream('./index.html');	// 创建一个流，将流进行对接
}

app.use(main);
app.listen(3000);

```
### 路由
#### ctx.request.path
ctx.request.path 外加if语句实现路由
#### 使用koa-route
继续下载
```
npm install --save koa-route
```
编写代码
```
const koa = require('koa');
const route = require('koa-route');
const app = new koa();

const about = ctx => {
	ctx.response.type = 'html';
	ctx.response.body = '<h2>hello world</h2>'
}

const main = ctx => {
	ctx.response.type = 'html';
	ctx.response.body = 'hello world'
}

app.use(route.get('/', main));
app.use(route.get('/about', about));
app.listen(3000);

```
访问 
http://127.0.0.1:3000/about
http://127.0.0.1:3000/
完成路由
### 静态资源
koa-static
npm  https://www.npmjs.com/package/koa-static
接着下载安装
```
npm i koa-static
```
编写入口文件。
```
const koa = require('koa');
const app = new koa();
const server = require('koa-static');	// 静态资源
const route = require('koa-route');

const static = server(__dirname + '/public');
const about = ctx => {
	ctx.response.type = 'html';
	ctx.response.body = '<h2>hello world</h2>';
}

app.use(route.get('/about', about));
app.use(static);

app.listen(3000);
```
访问 http://127.0.0.1:3000/1.png 将会返回public下的1.png文件
访问 http://127.0.0.1:3000/about 将会被路由进行捕获

### 重定向
```
const koa = require('koa');
const app = new koa();
const server = require('koa-static');	// 静态资源
const route = require('koa-route');

const static = server(__dirname + '/public');
const about = ctx => {
	ctx.response.type = 'html';
	ctx.response.body = '<h2>hello world</h2>';
}
const redirect = ctx => {
	ctx.response.redirect('/');
	ctx.response.body = '<a href="/">Index Page</a>'
};

app.use(route.get('/about', about));
app.use(route.get('/redirect', redirect));
app.use(static);

app.listen(3000);
```
上方完成了一次页面的跳转
### 中间件
```
const koa = require('koa');
const app = new koa();
const server = require('koa-static');	// 静态资源
const route = require('koa-route');

const static = server(__dirname + '/public');
const about = ctx => {
	ctx.response.type = 'html';
	ctx.response.body = '<h2>hello world</h2>';
}
const redirect = ctx => {
	ctx.response.redirect('/');
	ctx.response.body = '<a href="/">Index Page</a>'
};
const main = ctx => {
	ctx.response.body = 'hello world';
}

// 中间件
const logger = (ctx, next) => {
	console.log('info!')
	next();	// 继续调用下一个中间件
}
app.use(logger);
app.use(route.get('/', main));
app.use(route.get('/about', about));
app.use(route.get('/redirect', redirect));
app.use(static);

app.listen(3000);
```
上方的加载所有的都会使用一个中间件
#### 中间件栈
中间件栈实现的是一个先进后出
```
PS C:\Users\mingm\Desktop\ejs> node index.js
> one
> two
> three
< three
< two
< one

```
```
const koa = require('koa');
const app = new koa();
const server = require('koa-static');	// 静态资源
const route = require('koa-route');

const static = server(__dirname + '/public');
const about = ctx => {
	ctx.response.type = 'html';
	ctx.response.body = '<h2>hello world</h2>';
}
const redirect = ctx => {
	ctx.response.redirect('/');
	ctx.response.body = '<a href="/">Index Page</a>'
};
const main = ctx => {
	ctx.response.body = 'hello world';
}

// 中间件
const one = (ctx, next) => {
	console.log('> one');
	next();	// 装载下一个中间件
	console.log('< one');
}
const two = (ctx, next) => {
	console.log('> two');
	next();	
	console.log('< two');
}
const three = (ctx, next) => {
	console.log('> three');
	next();
	console.log('< three');
}
app.use(one);
app.use(two);
app.use(three);
app.use(route.get('/', main));
app.use(route.get('/about', about));
app.use(route.get('/redirect', redirect));
app.use(static);

app.listen(3000);

```
### 异步
是滴，node.js最重要的是异步，以及回调
#### es7的异步函数
一段代码直接说明
```
function resolveAfter2Seconds() {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve('resolved');
      console.log('我是执行结果4')
    }, 2000);
  });
}

async function asyncCall() {
  console.log('calling');
  console.log('我是执行结果3')
  var result = await resolveAfter2Seconds();
  console.log(result);
  console.log('我是执行结果2');
  // expected output: 'resolved'
}

asyncCall();
console.log('我是执行结果1');
```
输出结果为
```
> "calling"
> "我是执行结果3"
> "我是执行结果1"
> "我是执行结果4"
> "resolved"
> "我是执行结果2"
```
运行过程为先运行函数asyncCall，接着输出calling和结果3，继续到await语句的时候，为一个回调的语句，此时主线程，因为遇到await语句，将会直接进行输出执行结果1的内容，等待着resolveAfter2Seconds后执行完毕，进行回调。（Promise 对象为一个暂时保存回调内容的一个对象）Promise对象将会暂时保存运行的结果，运行结果为结果4和resolved，等待执行完毕以后，将会把暂时保存的内容，赋值给result变量，由于此时已经执行完毕，将会继续运行下方的内容，输出result中的内容，result中的内容为异步的执行的内容，接着，输出结果2，完成运行。
#### koa2中运行异步
```
const koa = require('koa');
const fs = require('fs');
const app = new koa();
const server = require('koa-static');	// 静态资源
const route = require('koa-route');

// 路由处理函数
const static = server(__dirname + '/public');
const main = async ctx => {
  ctx.response.type = 'html';
  console.log('one one one one');
  ctx.response.body = await file();
  console.log('one one one');
};
// 异步函数
function file() {
	return new Promise((resolve, reject) => {
		fs.readFile('./index.html', 'utf8', (err, data) => {
			if (err) {
				reject(console.log(err));
			} else {
				resolve(data);
				console.log('one one');
			}
		})
	})
}
// 中间件
const one = async (ctx, next) => {
	console.log('one');
	await next();
	console.log('one one one one one one ')
}


app.use(one);
app.use(route.get('/', main));
console.log('one one one one one one ')
app.use(static);

app.listen(3000);


```
结果
```
oen one one one one
one
one one one one
one one
one one one
one one one one one one

```
所有的都要使用异步操作，
由于全部都是异步，将会先调用最后的一个，
接着 调用中间件的内容。
由于中间件也为异步，将会继续异步main，
由于main也为异步，将会调用异步函数file中的内容。
接着，按照上面的顺序倒着回来，最后完成中间件
> ps 由于中间件的异步，这样就成功的模拟的中间件的正常的模型

##### 正常的中间件
```
const koa = require('koa');
const app = new koa();

const main = ctx => {
	ctx.response.type = 'html';
	console.log('3')
	ctx.response.body = '<h1>hello world</h1>'
	console.log('4');
};

const one = (ctx, next) => {
	console.log('info!');
	console.log('1')
	next();
	console.log('2')
}

app.use(one);
app.use(main);

app.listen(3000);
```
运行结果
```
info!
1
3
4
2
```
先进去，等到全部执行完成以后，在出来，中间件包裹着全部
##### 不加异步的中间件

```
const koa = require('koa');
const fs = require('fs');
const app = new koa();
const server = require('koa-static');	// 静态资源
const route = require('koa-route');

// 路由处理函数
const static = server(__dirname + '/public');
const main = async ctx => {
  ctx.response.type = 'html';
  console.log('one one one one');
  ctx.response.body = await file();
  console.log('one one one');
};
// 异步函数
function file() {
	return new Promise((resolve, reject) => {
		fs.readFile('./index.html', 'utf8', (err, data) => {
			if (err) {
				reject(console.log(err));
			} else {
				resolve(data);
				console.log('one one');
			}
		})
	})
}
// 中间件
const one =  (ctx, next) => {
	console.log('one');
	 next();
	console.log('one one one one one one ')
}


app.use(one);
app.use(route.get('/', main));
console.log('oen one one one one');
app.use(static);

app.listen(3000);

```
运行结果
```
oen one one one one
one
one one one one
one one one one one one
one one
one one one

```
可以发现，变现的'溢出'

### 中间件的合成
```
koa-compose
```
npm https://www.npmjs.com/package/koa-compose
下载安装
比较简单，看文档就行。

### 错误处理
同try类似使用throw抛出错误。

### cookies
ctx.cookies 用来读取cookies客户端发送的cookies内容
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/26/1.png)
```
const koa = require('koa');
const app = new koa();
const route = require('koa-route');

const main = (ctx) => {
	const n = Number(ctx.cookies.get('view') || 0) + 1;	// 获取客户端的cookice，如果不存在，直接取0，括号内的为一个选择语句，然后将其cookice进行加1操作
	ctx.cookies.set('view', n);	// 发送读取到的cookice
	ctx.response.type = 'html';
	ctx.response.body = n + 'views'; 	// 将结果输出
}

app.use(route.get('/', main));

app.listen(3000);
```
完成操作
### 表单操作
即post和get操作
继续使用模块 koa-body 
github https://github.com/dlau/koa-body
npm https://www.npmjs.com/package/koa-body
安装
```
npm i koa-body
```
支持json格式数据的提交哦
```
const Koa = require('koa');
const koaBody = require('koa-body');

const app = new Koa();

const main = ctx => {
  ctx.body = JSON.stringify(ctx.request.body);
};

app.use(koaBody());
app.use(main);

app.listen(3000);
```
客户端发送
```
name=Jack
```
格式为
```
text/plain
```
返回的都为字符串
文件上传暂时搞不定。

## ejs
### 需要先安装koa模板中间件
官网 https://www.npmjs.com/package/koa-views
```
npm install --save koa-views
```
index.js文件

```
const koa = require('koa');
const views = require('koa-views');
const path = require('path');
const app = new koa();

// 加载模板引擎
app.use(views(path.join(__dirname, './view'), { extension: 'ejs' }));

const main = async ctx => {
  let title = 'hello';
  await ctx.render('index', {title})
}
app.use(main);
app.listen(3000);

```
view下的index.ejs文件
```
<!doctype html>
<html>
<head>
	<title><%= title %></title>
</head>
<body>
<h1><%= title %></h1>
<p>hello world</p>
</body>
</html>
```
访问http://127.0.0.1:3000/
内容完成动态的更新

> ps 上传文件还是不太会，无奈