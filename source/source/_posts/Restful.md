title: Restful 表述性状态传递
author: Ming ming
tags:
  - Restful
  - 表述性状态传递
categories:
  - 前端
  - js
  - Node.js
date: 2018-07-30 00:37:00
---
Restful
REST表述性状态传递
REST通常基于使用HTTP，URL，XML，HTML。
REST使用的数据格式为JSON
# HTTP方法
GET 获取数据
PUT 用于更新和添加数据
DELETE 用于删除数据
POST 添加数据
# RESTful
一种基于http的架构方式
## 资源与URL
REStful全称为表述性状态转移。任何事物只要有被引用的必要都为资源。资源可以为实体，可以为抽象的概念。
### 资源举例
用户的手机号
用户的个人信息
用户手机潜在的价值
资源要被识别，要有唯一的标识。
URL可以看成资源的地址，可以看成资源的名称。
以github举例
仓库地址 https://github.com/mySoul8012/code
个人信息地址 https://github.com/mySoul8012
看URL可知仓库是在那个用户名下的
### 一些设计技巧
使用-或者_来进行资源的分割
使用/来表示资源的层级关系
使用？将资源进行过滤 /pulls?state=closed 表示已经关闭的推送请求，URL对应的是一种特定的查询结果。
.或者:表示同级的资源关系  
## 统一的资源接口
### 幂等
指一次或者多次请求一个资源的时候，应该具有相同的副作用。属于语义化的一个词
HTTP协议是一种面向资源的应用层协议
GET用于获取资源，不应该有副作用，所以称为其幂等性，例如请求一个资源的时候，不会改变其状态，此时说明GET具有幂等性
HTTP的DELETE，会删除资源，此时具有副作用，但是多次的副作用是相同的，还是具有其幂等性
POST为创建一个资源，每次副作用都是不同的，即没有幂等性
PUT为更新资源，对于同一个URL一次和多次的是相同的，此时具有幂等性
### GET
安全且幂等，表示一种获取的表示，会有缓存
### POST
不安全且不幂等，使用服务器端的管理的实例号生成资源，创建子资源，用于部分更新资源，如果没有修改则不会更新资源（一种乐观锁的表示）
### PUT
PUT不安全且幂等。用客户端管理的实例，创建一个资源，通过替换的方式更新资源
### DELETE
不安全但是幂等
### 四种总结
四种tcp方式，都是不安全，因为都是明文传输，需要使用https，完成加密，防止被抓包
### 一些问题
#### 一个框架 rails
官方网站 https://rubyonrails.org/
或者名为 Ruby on Rails
一种基于Ruby语言即面向对象，命令式，函数式，动态的通用编程语言，由日本科学家发明。特点是函数式编程
这是一个开源的web应用框架，严格按照MVC架构开发。
##### 应用
Github
推特
basecamp
Groupon
yellowpages
#### POST和PUT
为博客增加一个Java分类，生成的路径名为/categories/java 采用PUT方法，完成更新，因为此时是由客户端决定的
#### 客户端不一定支持HTTP方法
rails 框架是通过隐藏参数的方法，达到传递真实请求的方式
## 资源的表述
客户端获取的只是资源的表述。即资源的外在表现。
资源的表述包括数据和描述数据的元数据。
通过HTTP内容的协商，客户端通过头部信息达到
以github为例，JSON表述如下
<img src="https://www.iming.info/images/pasted-5.png">
### 一些常见的表述
URL里带上版本号
URL后缀区分表述格式
### 处理不支持的表述格式
<img src="https://www.iming.info/images/pasted-6.png">
## 资源的链接
超链接即状态引擎。
在表述格式里加入连接引导客户端。即这种链接称为流通性
以github为例
<img src="https://www.iming.info/images/pasted-7.png">

## 状态的转移
### 应用状态和资源状态
状态应该区分应用状态和资源状态。
客户端维护应用状态。
服务端维护资源状态。
客户端和服务端交互必须是无状态的。
Cookie是保存一些服务器不依赖于会话状态即可依赖的信息。
### 应用状态的转移
会话状态不是作为资源状态保存在服务器端的，而是被客户端作为应用状态进行跟踪的。客户端的应用在服务器端指引的超链接指引下发生变迁。
为一种架构模式
# 创建RESTful
创建一个JSON数据资源文件
```
{
	"user1": {
		"name": "mahesh",
		"password": "password",
		"profession": "teacher",
		"id": 1
	},
	"user2": {
		"name": "suresh",
		"password": "password2",
		"profession": "libraian",
		"id": 2
	},
	"user3": {
		"name": "ramesh",
		"password": "password3",
		"profession": "clerk",
		"id": 3
	},
}
```
即根据JSON文件有以下api
序号 | Url | Http方法 | 发送内容 | 结果
-----|------|---------|----------|-----
1    | listUsers | GET | 空  | 显示所有用户列表
2    | addUser  | POST | JSON字符串 | 添加新用户
3   |  deleteUsers | DELETE | JSON字符串 | 删除用户
4   | id   | GET  | 空 | 显示用户详细信息

# 获取用户列表
```
http://127.0.0.1:1937/listUsers
```
```
/*server.js*/
var express = require('express');	// 引入express框架
var app = express();
var fs = require('fs');	 // 引入文件模块

// 创建get请求
app.get('/listUsers', (req, res) => {
	fs.readFile(__dirname + '/' + 'users.json', 'utf8', (err, data) => {	// 读取文件
		console.log( data );
		res.end(data);	// 将读取到的内容返回给客户端
	});
});

// 启动server
var server = app.listen(1937, () => {
	console.log(server.address());
})


```
查看一下JSON数据
<img src="https://www.iming.info/images/pasted-8.png">
这样暂时完成了一部分
# 添加用户
> JSON.parse有个小坑，最后不允许使用，作为结尾

```
/*server.js*/
var express = require('express');	// 引入express框架
var app = express();
var fs = require('fs');	 // 引入文件模块

// 添加用户的数据
var user = {
	"user4": {
		"name":"mohit",
		"password":"password4",
		"profession":"teacher",
		"id":4
	}
}

// 创建get请求
app.get('/addUser', (req, res) => {
	// 读取已存在的数据
	fs.readFile( __dirname + "/" + "users.json", "utf8", (err, data) => {
		if (err) {
			return console.log(err);
		};

		data = JSON.parse(data);	// 将传入的JSON转换为对象格式
		data["user4"] = user["user4"];	
		console.log(data);
		res.end( JSON.stringify(data) );	// 将对象转换成为JSON格式
	});
});

// 启动server
var server = app.listen(1937, () => {
	console.log(server.address());
})
```
```
{
	"user1": {
		"name": "mahesh",
		"password": "password",
		"profession": "teacher",
		"id": 1
	},
	"user2": {
		"name": "suresh",
		"password": "password2",
		"profession": "libraian",
		"id": 2
	},
	"user3": {
		"name": "ramesh",
		"password": "password3",
		"profession": "clerk",
		"id": 3
	}
}
```
访问 http://127.0.0.1:1937/addUser
返回的JSON数据
<img src="https://www.iming.info/images/pasted-10.png">
此时本地的JSON数据仍旧未发生改变，如果要其发生改变需要fs的写模块，将JSON数据写入JSON文件中

# 显示用户详情
```
/*server.js*/
var express = require('express');	// 引入express框架
var app = express();
var fs = require('fs');	 // 引入文件模块

// 添加用户的数据
var user = {
	"user4": {
		"name":"mohit",
		"password":"password4",
		"profession":"teacher",
		"id":4
	}
}

// 创建获取用户列表路由
app.get('/listUsers', function (req, res) {
   fs.readFile( __dirname + "/" + "users.json", 'utf8', function (err, data) {
       console.log( data );
       res.end( data );
   });
})

// 创建添加用户路由请求
app.get('/addUser', (req, res) => {
	// 读取已存在的数据
	fs.readFile( __dirname + "/" + "users.json", "utf8", (err, data) => {
		if (err) {
			return console.log(err);
		};

		data = JSON.parse(data);	// 将传入的JSON转换为对象格式
		data["user4"] = user["user4"];	
		console.log(data);
		res.end( JSON.stringify(data) );	// 将对象转换成为JSON格式
	});
});

// 添加显示用户详情路由
app.get('/:id', (req, res) => {
	// 首先读取已存在的用户
	fs.readFile( __dirname + '/' + "users.json", 'utf8', (err, data) => {
		data = JSON.parse( data );
		var user = data["user" + req.params.id]	// 获取get得到的值
		console.log( user );
		res.end( JSON.stringify(user) );
	})
})

// 启动server
var server = app.listen(1937, () => {
	console.log(server.address());
})

```
查看浏览器得到的JSON数据
<img src="https://www.iming.info/images/pasted-11.png">

# 删除用户
```
/*server.js*/
var express = require('express');	// 引入express框架
var app = express();
var fs = require('fs');	 // 引入文件模块


// 创建获取用户列表路由
app.get('/listUsers', (req, res) => {
   fs.readFile( __dirname + "/" + "users.json", 'utf8', (err, data) => {
       console.log( data );
       res.end( data );
   });
})

// 创建添加用户路由请求
app.get('/addUser', (req, res) => {
	// 读取已存在的数据
	fs.readFile( __dirname + "/" + "users.json", "utf8", (err, data) => {
		if (err) {
			return console.log(err);
		};

		// 添加用户
		var user = {
		"user4": {
		"name":"mohit",
		"password":"password4",
		"profession":"teacher",
		"id":4
				}
		}

		data = JSON.parse(data);	// 将传入的JSON转换为对象格式
		data["user4"] = user["user4"];	
		console.log(data);
		res.end( JSON.stringify(data) );	// 将对象转换成为JSON格式
	});
});

// 添加显示用户详情路由
app.get('/:id', (req, res) => {
	// 首先读取已存在的用户
	fs.readFile( __dirname + '/' + "users.json", 'utf8', (err, data) => {
		data = JSON.parse( data );
		var user = data["user" + req.params.id]	// 获取get得到的值
		console.log( user );
		res.end( JSON.stringify(user) );
	})
})

var app = express();	// 不清楚为什么这里要重新定义？
// 删除用户
app.get('/deleteUser', (req, res) => {

   // 首先获取用户信息
   fs.readFile( __dirname + "/" + "users.json", 'utf8', (err, data) => {
       data = JSON.parse( data );
       delete data["user" + 2];
       
       console.log( data );
       res.end( JSON.stringify(data));
   });
})

// 启动server
var server = app.listen(1937, () => {
	console.log(server.address());
})

```
不清楚为什么要重新定义一个类。

![upload successful](/images/pasted-10.png)


![upload successful](/images/pasted-11.png)