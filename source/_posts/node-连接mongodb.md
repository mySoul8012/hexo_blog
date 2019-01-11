title: node 连接mongodb
author: Ming ming
tags:
  - node.js
  - mongodb
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-08-01 00:14:00
---
Node.js连接MongoDB
# 一些介绍
mongodb https://www.npmjs.com/package/mongodb
github项目地址 https://github.com/mongodb/node-mongodb-native
属于官方提供的mongodb驱动
文档 http://mongodb.github.io/node-mongodb-native/3.1/api/
项目主页 http://mongodb.github.io/node-mongodb-native/
属于一个轮子，已经造好了
# 安装mongodb
```
PS C:\Users\mingm\Desktop\node> npm install mongodb --save
npm WARN saveError ENOENT: no such file or directory, open 'C:\Users\mingm\Desktop\node\package.json'
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN enoent ENOENT: no such file or directory, open 'C:\Users\mingm\Desktop\node\package.json'
npm WARN node No description
npm WARN node No repository field.
npm WARN node No README data
npm WARN node No license field.

+ mongodb@3.1.1
added 7 packages from 5 contributors and audited 7 packages in 108.492s
found 0 vulnerabilities

PS C:\Users\mingm\Desktop\node>
```
# 创建数据库
好吧，因为各种版本的缘故，需要使用新的解析器。所以需要设置options的参数
即
```
useNewUrlParser: true
```
2.0的驱动程序
旧版本不需要。
```
PS C:\Users\mingm\Desktop\node> node test.js
数据库连接建立
PS C:\Users\mingm\Desktop\node>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	console.log("数据库连接建立");
	db.close();
})
```
连接以后创建了一个mingming的数据库
```
> show dbs;
admin   0.000GB
config  0.000GB
local   0.000GB
> use local;
switched to db local
>
```
查询了一下，还没有，因为没有往里面添加数据
# 创建集合
即，创建一张表
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	console.log("数据库连接建立");
	var dbase = db.db('mingming');	// 选择数据库为mingming
	dbase.createCollection('site', (err, res) => {	// 创建数据库为mingming下的site集合
		if(err) {
			throw err;
		}
		console.log('创建集合！');
		db.close();
	});
});
```
```
PS C:\Users\mingm\Desktop\node> node test.js
数据库连接建立
创建集合！
PS C:\Users\mingm\Desktop\node>
```
看一下这张表
```
> show dbs;
admin     0.000GB
config    0.000GB
local     0.000GB
mingming  0.000GB
> use mingming
switched to db mingming
> show ceoolection;
2018-07-31T23:12:55.014+0800 E QUERY    [js] Error: don't know how to show [ceoolection] :
shellHelper.show@src/mongo/shell/utils.js:1043:11
shellHelper@src/mongo/shell/utils.js:755:15
@(shellhelp2):1:1
> show collections;
site
> db.site.find();
>
```
# CURD
## 插入数据
```
PS C:\Users\mingm\Desktop\node> node test.js
文档插入成功！
PS C:\Users\mingm\Desktop\node>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	var dbo = db.db('mingming');
	var myobj = { name:"mingming", url:"www.iming.info" };
	dbo.collection('site').insertOne(myobj, (err, res) => {	// mongodb语法 mingming.site.insert(myObj);
		if(err) {
			throw err;
		}
		console.log("文档插入成功！");
		db.close();
	});
});
```
```
> db.site.find();
{ "_id" : ObjectId("5b607e4d5b8ced1c5cb8a7e4"), "name" : "mingming", "url" : "www.iming.info" }
{ "_id" : ObjectId("5b607e6ee7b6e82d604d5a4d"), "name" : "mingming", "url" : "www.iming.info" }
>
```
## 插入多条数据
```
> db.site.find().pretty();
{
        "_id" : ObjectId("5b607e4d5b8ced1c5cb8a7e4"),
        "name" : "mingming",
        "url" : "www.iming.info"
}
{
        "_id" : ObjectId("5b607e6ee7b6e82d604d5a4d"),
        "name" : "mingming",
        "url" : "www.iming.info"
}
{
        "_id" : ObjectId("5b6080037aa38239e46c0dc1"),
        "name" : "mingming",
        "url" : "www.iming.info",
        "type" : "cn"
}
{
        "_id" : ObjectId("5b6080037aa38239e46c0dc2"),
        "name" : "google",
        "url" : "www.google.com.hk",
        "type" : "un"
}
{
        "_id" : ObjectId("5b6080037aa38239e46c0dc3"),
        "name" : "twitter",
        "url" : "www.twitter.com",
        "type" : "un"
}
>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	var dbo = db.db('mingming');
	var myobj = [
		{name:"mingming", url:"www.iming.info" , type:"cn"},
		{name:"google", url:"www.google.com.hk", type:"un"},
		{name:"twitter", url:"www.twitter.com", type:"un"},
	];
	dbo.collection('site').insertMany(myobj, (err, res) => {	// mongodb语法 mingming.site.insert(myObj);
		if(err) {
			throw err;
		}
		console.log("文档插入成功！");
		db.close();
	});
});
```
```
PS C:\Users\mingm\Desktop\node> node test.js
文档插入成功！
PS C:\Users\mingm\Desktop\node>
```
## 查询数据
```
PS C:\Users\mingm\Desktop\node> node test.js
[ { _id: 5b607e4d5b8ced1c5cb8a7e4,
    name: 'mingming',
    url: 'www.iming.info' },
  { _id: 5b607e6ee7b6e82d604d5a4d,
    name: 'mingming',
    url: 'www.iming.info' },
  { _id: 5b6080037aa38239e46c0dc1,
    name: 'mingming',
    url: 'www.iming.info',
    type: 'cn' },
  { _id: 5b6080037aa38239e46c0dc2,
    name: 'google',
    url: 'www.google.com.hk',
    type: 'un' },
  { _id: 5b6080037aa38239e46c0dc3,
    name: 'twitter',
    url: 'www.twitter.com',
    type: 'un' } ]
PS C:\Users\mingm\Desktop\node>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	var dbo = db.db('mingming');
	dbo.collection('site').find({}).toArray((err, result) => {	// 使用find()查询完成以后，使用toArray将查询到的数据完成回调
		if (err) {
			throw err;
		}
		console.log(result);	// 将回调的结果输出（由于结果是暂时保存在内存中的，确保有足够大的内存保存，或者使用流也可）
		db.close();
	});
});;
```
```
> db.site.find().pretty();
{
        "_id" : ObjectId("5b607e4d5b8ced1c5cb8a7e4"),
        "name" : "mingming",
        "url" : "www.iming.info"
}
{
        "_id" : ObjectId("5b607e6ee7b6e82d604d5a4d"),
        "name" : "mingming",
        "url" : "www.iming.info"
}
{
        "_id" : ObjectId("5b6080037aa38239e46c0dc1"),
        "name" : "mingming",
        "url" : "www.iming.info",
        "type" : "cn"
}
{
        "_id" : ObjectId("5b6080037aa38239e46c0dc2"),
        "name" : "google",
        "url" : "www.google.com.hk",
        "type" : "un"
}
{
        "_id" : ObjectId("5b6080037aa38239e46c0dc3"),
        "name" : "twitter",
        "url" : "www.twitter.com",
        "type" : "un"
}
>
```
## 查询指定条件的数据
```
PS C:\Users\mingm\Desktop\node> node test.js
[ { _id: 5b607e4d5b8ced1c5cb8a7e4,
    name: 'mingming',
    url: 'www.iming.info' },
  { _id: 5b607e6ee7b6e82d604d5a4d,
    name: 'mingming',
    url: 'www.iming.info' },
  { _id: 5b6080037aa38239e46c0dc1,
    name: 'mingming',
    url: 'www.iming.info',
    type: 'cn' } ]
PS C:\Users\mingm\Desktop\node>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	var dbo = db.db('mingming');
	var whereStr = {"name":"mingming"};	// 查询条件
	dbo.collection('site').find(whereStr).toArray((err, result) => {	// 使用find()查询完成以后，使用toArray将查询到的数据完成回调
		if (err) {
			throw err;
		}
		console.log(result);	// 将回调的结果输出（由于结果是暂时保存在内存中的，确保有足够大的内存保存，或者使用流也可）
		db.close();
	});
});;
```
## 更新数据
```
PS C:\Users\mingm\Desktop\node> node test.js
文档更新成功
PS C:\Users\mingm\Desktop\node>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	var dbo = db.db('mingming');
	var whereStr = {"name":"mingming"};	// 查询条件
	var updateStr = {$set: {"url": "AmingA"}};
	dbo.collection('site').updateOne(whereStr, updateStr, (err, result) => {	// 使用find()查询完成以后，使用toArray将查询到的数据完成回调
		if (err) {
			throw err;
		}
		console.log('文档更新成功');	// 将回调的结果输出（由于结果是暂时保存在内存中的，确保有足够大的内存保存，或者使用流也可）
		db.close();
	});
});;
```
```
> db.site.find({"name":"mingming"}).pretty();
{
        "_id" : ObjectId("5b607e4d5b8ced1c5cb8a7e4"),
        "name" : "mingming",
        "url" : "AmingA"
}
{
        "_id" : ObjectId("5b607e6ee7b6e82d604d5a4d"),
        "name" : "mingming",
        "url" : "www.iming.info"
}
{
        "_id" : ObjectId("5b6080037aa38239e46c0dc1"),
        "name" : "mingming",
        "url" : "www.iming.info",
        "type" : "cn"
}
>
```
mongodb的更新
```
> db.site.update({"name":"mingming"}, {$set: {"url":""}});
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
> db.site.find({"name":"mingming"});
{ "_id" : ObjectId("5b607e4d5b8ced1c5cb8a7e4"), "name" : "mingming", "url" : "" }
{ "_id" : ObjectId("5b607e6ee7b6e82d604d5a4d"), "name" : "mingming", "url" : "www.iming.info" }
{ "_id" : ObjectId("5b6080037aa38239e46c0dc1"), "name" : "mingming", "url" : "www.iming.info", "type" : "cn" }
>
```
## 更新多条数据
```
PS C:\Users\mingm\Desktop\node> node test.js
{ n: 3, nModified: 3, ok: 1 }
PS C:\Users\mingm\Desktop\node>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	var dbo = db.db('mingming');
	var whereStr = {"name":"mingming"};	// 查询条件
	var updateStr = {$set: {"url": ""}};
	dbo.collection('site').updateMany(whereStr, updateStr, (err, result) => {	// 使用find()查询完成以后，使用toArray将查询到的数据完成回调
		if (err) {
			throw err;
		}
		console.log(result.result);	// 将回调的结果输出（由于结果是暂时保存在内存中的，确保有足够大的内存保存，或者使用流也可）
		db.close();
	});
});;
```
```
> db.site.find({"name":"mingming"});
{ "_id" : ObjectId("5b607e4d5b8ced1c5cb8a7e4"), "name" : "mingming", "url" : "" }
{ "_id" : ObjectId("5b607e6ee7b6e82d604d5a4d"), "name" : "mingming", "url" : "" }
{ "_id" : ObjectId("5b6080037aa38239e46c0dc1"), "name" : "mingming", "url" : "", "type" : "cn" }
>
```
## 删除数据
同样deleteOne和deleteMany()不在阐述
# 排序
使用sort()完成排序
```
PS C:\Users\mingm\Desktop\node> node test.js
[ { _id: 5b6080037aa38239e46c0dc2,
    name: 'google',
    url: 'www.google.com.hk',
    type: 'un' },
  { _id: 5b6080037aa38239e46c0dc3,
    name: 'twitter',
    url: 'www.twitter.com',
    type: 'un' },
  { _id: 5b6080037aa38239e46c0dc1,
    name: 'mingming',
    url: '',
    type: 'cn' },
  { _id: 5b607e4d5b8ced1c5cb8a7e4, name: 'mingming', url: '' },
  { _id: 5b607e6ee7b6e82d604d5a4d, name: 'mingming', url: '' } ]
PS C:\Users\mingm\Desktop\node>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	var dbo = db.db('mingming');
	var mysort = { type:-1 };	// 降序
	dbo.collection('site').find().sort(mysort).toArray((err, result) => {
			if (err) {
			throw err;
		}
		console.log(result);	// 将回调的结果输出（由于结果是暂时保存在内存中的，确保有足够大的内存保存，或者使用流也可）
		db.close();
	});
});;

```
mongodb语法
```
> db.site.find({}).sort({type:-1});
{ "_id" : ObjectId("5b6080037aa38239e46c0dc2"), "name" : "google", "url" : "www.google.com.hk", "type" : "un" }
{ "_id" : ObjectId("5b6080037aa38239e46c0dc3"), "name" : "twitter", "url" : "www.twitter.com", "type" : "un" }
{ "_id" : ObjectId("5b6080037aa38239e46c0dc1"), "name" : "mingming", "url" : "", "type" : "cn" }
{ "_id" : ObjectId("5b607e4d5b8ced1c5cb8a7e4"), "name" : "mingming", "url" : "" }
{ "_id" : ObjectId("5b607e6ee7b6e82d604d5a4d"), "name" : "mingming", "url" : "" }
>
```
# 分页
使用limit，分页和排序使用的统统是通道（一个来自linux的概念）
```
PS C:\Users\mingm\Desktop\node> node test.js
[ { _id: 5b607e4d5b8ced1c5cb8a7e4, name: 'mingming', url: '' },
  { _id: 5b607e6ee7b6e82d604d5a4d, name: 'mingming', url: '' } ]
PS C:\Users\mingm\Desktop\node>
```
## 跳过指定条数
```
PS C:\Users\mingm\Desktop\node> node test.js
[ { _id: 5b6080037aa38239e46c0dc1,
    name: 'mingming',
    url: '',
    type: 'cn' },
  { _id: 5b6080037aa38239e46c0dc2,
    name: 'google',
    url: 'www.google.com.hk',
    type: 'un' } ]
PS C:\Users\mingm\Desktop\node>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	var dbo = db.db('mingming');
	dbo.collection('site').find().skip(2).limit(2).toArray((err, result) => {
			if (err) {
			throw err;
		}
		console.log(result);	// 将回调的结果输出（由于结果是暂时保存在内存中的，确保有足够大的内存保存，或者使用流也可）
		db.close();
	});
});;
```
# 随机读取一条数据
```
PS C:\Users\mingm\Desktop\node> node test.js
[ { _id: 5b6080037aa38239e46c0dc2,
    name: 'google',
    url: 'www.google.com.hk',
    type: 'un' } ]
[ { _id: 5b6080037aa38239e46c0dc1,
    name: 'mingming',
    url: '',
    type: 'cn' } ]
[ { _id: 5b6080037aa38239e46c0dc2,
    name: 'google',
    url: 'www.google.com.hk',
    type: 'un' } ]
[ { _id: 5b607e6ee7b6e82d604d5a4d, name: 'mingming', url: '' } ]
[ { _id: 5b607e4d5b8ced1c5cb8a7e4, name: 'mingming', url: '' } ]
[ { _id: 5b6080037aa38239e46c0dc1,
    name: 'mingming',
    url: '',
    type: 'cn' } ]
[ { _id: 5b607e4d5b8ced1c5cb8a7e4, name: 'mingming', url: '' } ]
[ { _id: 5b607e6ee7b6e82d604d5a4d, name: 'mingming', url: '' } ]
[ { _id: 5b607e6ee7b6e82d604d5a4d, name: 'mingming', url: '' } ]
[ { _id: 5b607e4d5b8ced1c5cb8a7e4, name: 'mingming', url: '' } ]
PS C:\Users\mingm\Desktop\node> node test.js
[ { _id: 5b6080037aa38239e46c0dc2,
    name: 'google',
    url: 'www.google.com.hk',
    type: 'un' } ]
[ { _id: 5b6080037aa38239e46c0dc1,
    name: 'mingming',
    url: '',
    type: 'cn' } ]
[ { _id: 5b6080037aa38239e46c0dc3,
    name: 'twitter',
    url: 'www.twitter.com',
    type: 'un' } ]
[ { _id: 5b607e6ee7b6e82d604d5a4d, name: 'mingming', url: '' } ]
[ { _id: 5b607e6ee7b6e82d604d5a4d, name: 'mingming', url: '' } ]
[ { _id: 5b6080037aa38239e46c0dc1,
    name: 'mingming',
    url: '',
    type: 'cn' } ]
[ { _id: 5b6080037aa38239e46c0dc1,
    name: 'mingming',
    url: '',
    type: 'cn' } ]
[ { _id: 5b607e4d5b8ced1c5cb8a7e4, name: 'mingming', url: '' } ]
[ { _id: 5b6080037aa38239e46c0dc3,
    name: 'twitter',
    url: 'www.twitter.com',
    type: 'un' } ]
[ { _id: 5b6080037aa38239e46c0dc3,
    name: 'twitter',
    url: 'www.twitter.com',
    type: 'un' } ]
PS C:\Users\mingm\Desktop\node>
```
```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/mingming";	// 连接的url

MongoClient.connect(url, { useNewUrlParser: true }, (err, db) => {	// 调用封装好的connect按照url建立和MongoDB之间的连接
	if (err) {
		throw err;
	}
	var dbo = db.db('mingming');
	for(var i=0; i<10; i++){
		dbo.collection('site').aggregate([{$sample: {size:1}}]).toArray((err, result) => {
				if (err) {
				throw err;
			}
			console.log(result);	// 将回调的结果输出（由于结果是暂时保存在内存中的，确保有足够大的内存保存，或者使用流也可）
		});
	};
	db.close();
});;
```
使用的同样是管道

# 博客
www.iming.info