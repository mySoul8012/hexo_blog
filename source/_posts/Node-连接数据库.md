title: Node 连接mysql数据库
author: Ming ming
tags:
  - node.js
  - mysql
  - 数据库
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-31 00:55:00
---
JXcore作者已经不维护了。
github地址 https://github.com/jxcore/jxcore
所以下面是Node.js连接Mysql
Node.js 连接Mysql
使用的内容作者依旧在维护
# 安装
```
PS C:\Users\mingm\Desktop\test> npm install mysql --save
npm WARN saveError ENOENT: no such file or directory, open 'C:\Users\mingm\Desktop\test\package.json'
npm WARN enoent ENOENT: no such file or directory, open 'C:\Users\mingm\Desktop\test\package.json'
npm WARN test No description
npm WARN test No repository field.
npm WARN test No README data
npm WARN test No license field.

+ mysql@2.16.0
updated 1 package and audited 296 packages in 2.366s
found 0 vulnerabilities

PS C:\Users\mingm\Desktop\test>
```
npm地址 https://www.npmjs.com/package/mysql
github 地址 https://github.com/mysqljs/mysql
文档地址 https://www.npmjs.com/package/mysql#install 查看一些文档的时候需要在这里查看
# 连接数据库
由于本地已经有mysql了。
```
PS C:\Users\mingm\Desktop\test> node test.js
The solution is: 2
```
```
var mysql = require('mysql');
var connection = mysql.createConnection({
	host: 'student.iming.info',	// 连接的服务器
	user: 'root',	// 用户名
	password: '********',	// 用户密码
	database: 'ming'	// 选择的库
});

connection.connect();	// 创建一个mysql的线程

connection.query('SELECT 1 + 1 AS solution', (err, results, fields) => {
	if (err) {
		throw  err;
	};

	console.log('The solution is:', results[0].solution);	// 返回第一条记录的solution列的内容
});
```
好啦。这就完成了一次连接，使用的是npm下载的mysql模块，使用的是c++语言编写的

# 数据库操作
```
PS C:\Users\mingm\Desktop\test> node test.js
------------SELECT-------------
[ RowDataPacket {
    id: 1,
    name: 'Google',
    url: 'https://www.google.cm/',
    alexa: 1,
    country: 'USA' },
  RowDataPacket {
    id: 2,
    name: '淘宝',
    url: 'https://www.taobao.com/',
    alexa: 13,
    country: 'CN' },
  RowDataPacket {
    id: 3,
    name: '微博',
    url: 'http://weibo.com/',
    alexa: 20,
    country: 'CN' },
  RowDataPacket {
    id: 5,
    name: 'Facebook',
    url: 'https://www.facebook.com/',
    alexa: 3,
    country: 'USA' } ]
--------------------------------
```
```
var mysql = require('mysql');
var connection = mysql.createConnection({
	host: 'student.iming.info',	// 连接的服务器
	user: 'root',	// 用户名
	password: '******************',	// 用户密码
	database: 'ming'	// 选择的库
});

connection.connect();	// 创建一个mysql的线程

// 推荐查询语句使用大写。方便分辨和后期的维护
var sql = 'SELECT * FROM websites';	// sql命令
connection.query(sql, (err, results, fields) => {	// results 为查询的结果 fields 为返回的信息
	if (err) {
		console.log('[SELECT ERROR] -', err.message);
		return;
	};

	console.log('------------SELECT-------------');	
	console.log(results);	// 输出查询的结果
	console.log('--------------------------------');
});
```
下面该是数据库的原子操作了。即CULD
# 插入数据
```
PS C:\Users\mingm\Desktop\test> node test.js
------------------INSERT--------------------------
INSERT ID OkPacket {
  fieldCount: 0,
  affectedRows: 1,
  insertId: 6,
  serverStatus: 2,
  warningCount: 0,
  message: '',
  protocol41: true,
  changedRows: 0 }
-------------------------------------------------


PS C:\Users\mingm\Desktop\test>
```
```
var mysql = require('mysql');
var connection = mysql.createConnection({
	host: 'student.iming.info',	// 连接的服务器
	user: 'root',	// 用户名
	password: '*******************',	// 用户密码
	database: 'ming'	// 选择的库
});

connection.connect();	// 创建一个mysql的线程

var addSql = 'INSERT INTO websites(id, name, url, alexa, country) VALUES(0, ?, ?, ?, ?)'; // 创建一个通用的sql，并预留出填补的空位
var addSqlParams = ['mySoul', 'https://www.iming.info', '0000000', 'CN'];

connection.query(addSql, addSqlParams, (err, result) => {
	if(err){
		console.log('[INSERT ERROR] -', err.message);
		return;
	}

	console.log('------------------INSERT--------------------------')
	console.log('INSERT ID', result);
	console.log('-------------------------------------------------\n\n');
});
```
登陆数据库查看
```
mysql> select * from websites;
+----+----------+---------------------------+-------+---------+
| id | name     | url                       | alexa | country |
+----+----------+---------------------------+-------+---------+
|  1 | Google   | https://www.google.cm/    |     1 | USA     |
|  2 | 淘宝     | https://www.taobao.com/   |    13 | CN      |
|  3 | 微博     | http://weibo.com/         |    20 | CN      |
|  5 | Facebook | https://www.facebook.com/ |     3 | USA     |
|  6 | mySoul   | https://www.iming.info    |     0 | CN      |
+----+----------+---------------------------+-------+---------+
5 rows in set (0.02 sec)

mysql>
```
很明显已经插入完成
> 亲，如果数据库ID设置了自动递增，即使用了AUTO_INCREMENT，建议使用自增，因为数据库索引是B+树的加快查询速度。所以一般都设置自增序列

> 关于JSON 因为数据通信是使用JSON的，所以两个方法，一个JSON转对象 JSON.parse
>　对象转JSON JSON.stringify
在加上一个node的框架Express，即可完成和浏览器的交互，这样就完成一个web服务器的搭建

# 删除数据
```
var mysql = require('mysql');
var connection = mysql.createConnection({
	host: 'student.iming.info',	// 连接的服务器
	user: 'root',	// 用户名
	password: '****************',	// 用户密码
	database: 'ming'	// 选择的库
});

connection.connect();	// 创建一个mysql的线程

var delSql = 'DELETE FROM websites WHERE id=6';
connection.query(delSql, (err, result) => {
	if(err) {
		console.log('[DELETE ERROR] -', err.message);
		return;
	}

	console.log('------------DELETE------------------');
	console.log('DELETE affectedRows', result);
	console.log('------------------------------------');
})

connection.end();
```
```
PS C:\Users\mingm\Desktop\test> node test.js
------------DELETE------------------
DELETE affectedRows OkPacket {
  fieldCount: 0,
  affectedRows: 1,
  insertId: 0,
  serverStatus: 2,
  warningCount: 0,
  message: '',
  protocol41: true,
  changedRows: 0 }
------------------------------------
PS C:\Users\mingm\Desktop\test>
```

# 博客
www.iming.info