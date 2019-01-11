title: mongodb
author: Ming ming
tags:
  - 数据库
  - mongodb
categories:
  - 前端
  - 数据库
  - mongodb
date: 2018-07-31 03:01:00
---
MongDB
MongDB一种面向文档的数据库管理系统，由C++写成。
官网 https://www.mongodb.com/
github https://github.com/mongodb/mongo
# NoSQL
NoSQL不使用SQL作为查询语言。其数据的储存可以不需要固定的表格形式。也会经常的被使用sql的join
## 特点
通常提供弱的一致性保护， 但保证最终的一致性。
## 关系型数据库遵守的特点
ACID
即 A 原子性 事物中的操作要么全做，要么都做
C 一致性 数据库一直要处于一致的状态
I 独立性 并发事物之间不会相互影响（即 三级封锁协议，锁的形成）
D 持久性 数据库提交完成以后持久保存
## 分布式系统
分布式系统是由多台计算机和通信软件组成，通过网络相互连接。分布式系统是建立在网络之上的系统。分布式系统的区别在于操作系统。
## 分布式系统的优点
可靠性（容错机制）可扩展性（可以随意的增加更多的机器）资源共享（数据之间可以共享）灵活性（由于该系统是非常灵活的，易于安装）更快的速度（分布式计算拥有更快的计算能力，易于进行更多的计算）开放系统（由于其系统是开放，本地和远程都可直接访问）更高的性能（相比于集群，拥有更高的性能）
## 缺点
故障不易排除，拥有更少的软件，网络问题，安全性问题
## RDBMS 和 NoSQL
### RDBMS
为关系型数据库的基础
拥有高度的组织化结构数据
拥有结构化查询语言
数据和关系都储存在单独的表中
严格的一致性
基础的事物
### NoSQL
没有声明式查询语言
没有预定义模式
键值对储存，列储存，文档储存，图形数据库
最终的一致性而不保证过程的一致性
非结构化和不可预知的数据
CAP定理
高性能，高可用性和高伸缩性
#### CAP定理
CAP定理被称为布鲁尔定理，对于分布式系统来说，不可能满足以下三点
一致性 （等同于所有节点访问同一份最新数据的副本）
可用性 （每次请求都能获取到非错误的响应）
分区容错性（系统中任意错误都不会导致错误的丢失）
更多 https://ja.wikipedia.org/wiki/CAP%E5%AE%9A%E7%90%86
根据CAP原理 将数据库分类如下 满足 CA 原则、满足 CP 原则和满足 AP 原则的三大类
## BASE
BASE：Basically Available, Soft-state, Eventually Consistent。
BASE是NoSQL数据库通常对可用性及一致性的弱要求原则
## NoSQL数据库分类
列储存 | 按照列储存数据 | 代表
--------|--------------| [Hbase][1] 
文档储存 | 类似于JSON的格式，储存的内容是文档类型的，这样有机会对某些字段建立索引，实现关系数据库的某些功能。| Mongdb
key-value 储存 | 通过key快速查询到value | Redis
图储存 | 图形储存 | [Flockdb][2] 来自于推特
对象储存 | 通过面向对象的语法来操作数据库 | Versant
xml数据 | 储存XML数据 | http://basex.org/
## 谁在用
Google（(*^__^*) 嘻嘻……） 
http://digg.com/
https://www.mheducation.com/home.html   
http://digital.vpr.net 
https://foursquare.com/  
# MongoDB
由C++编写，MongoDB将数据储存为一个文档
数据结构由键值对组成。其文档类似于JSON对象
##　特点
丰富的表达式，支持任何索引，负载的增加，批量处理和聚合操作等等。。。。
## 历史
2007年来的
## MongDB下载，安装
访问官网下载 https://www.mongodb.com/download-center#community
其中文社区 http://www.mongoing.com/
一个可视化工具 https://www.nosqlclient.com/
或者 http://mms.litixsoft.de/index.php?lang=en

因为某些缘故，导致灯塔国的东东很慢很慢
一直感觉安装的。。。很炫酷。。
没办法。。。灯塔国的。。好吧，安装完毕
# 设置数据目录
```
PS C:\> cd data
PS C:\data> ls
PS C:\data> mkdir db


    目录: C:\data


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        2018/7/31      2:37                db


PS C:\data> ls


    目录: C:\data


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        2018/7/31      2:37                db


PS C:\data> cd db
PS C:\data\db>
```
# 设置环境变量
C:\Program Files\MongoDB\Server\4.0\bin
# 打开Powershell
```
PS C:\Program Files\MongoDB\Server\4.0\bin> mongod  -dbpath c:\data\db
```
执行mongod创建数据目录
# 连接
```
PS C:\Users\mingm\Desktop> mongo.exe
MongoDB shell version v4.0.0
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 4.0.0
Server has startup warnings:
2018-07-31T02:32:28.615+0800 I CONTROL  [initandlisten]
2018-07-31T02:32:28.616+0800 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2018-07-31T02:32:28.616+0800 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2018-07-31T02:32:28.616+0800 I CONTROL  [initandlisten]
---
Enable MongoDB's free cloud-based monitoring service to collect and display
metrics about your deployment (disk utilization, CPU, operation statistics,
etc).

The monitoring data will be available on a MongoDB website with a unique
URL created for you. Anyone you share the URL with will also be able to
view this page. MongoDB may use this information to make product
improvements and to suggest MongoDB products and deployment options to you.

To enable free monitoring, run the following command:
db.enableFreeMonitoring()
---

>
```
## 可视化连接
mongodb://127.0.0.1:27017
将其复制上去就行了

ok好啦，至此安装完成
这是一个JavaScript shell
\(^o^)/ 瞬间拥有亲切感。
js的语言终于可以再次用上

# mongodb概念解析
sql | mongodb | 解释/说明
----|---------|------------
databass | databass | 数据库
table | collection | 数据库表/集合
row | document | 行/文档
colunm | field | 字段/域
index | index | 索引
table joins |  | 表连接
primary key | primary key | 主键/nongodb自动将_id设置为主键

一张图说明
<img src="https://www.iming.info/images/pasted-12.png">
# 数据库
一个mongodb可以建立多个数据库
```
> show dbs;
admin   0.000GB
config  0.000GB
local   0.000GB
>
```
使用db显示当前数据库的对象和集合
```
> db
test
>
```
类似于关系型数据库中的表
使用use命令连接到一个指定的数据库
> 震惊了。。。竟然和mysql一个样子

```
> use local
switched to db local
> db
local
>
```
# 文档
文档是一组键值对的集合，
一些属于和关系型数据库的对比
关系型数据库 | 非关系型数据库
-------------|---------------
数据库 | 数据库
表格 | 集合
行 | 文档
列 | 字段
表连接 | 嵌入文档
主键 | 主键 mongodb提供key为_id

注意：
1. 文档中的键值对有序
2. 文档中的值，不仅仅是可以是字符串，也可以是整个嵌入的文档
3. MongoDB类型区分大小写
4. mongodb不能有重复键
5. 文档的键是字符串
6. 键不能含有\0 因为\0代表着结束
7. $有特定含义，不能随便使用
8. _开头的键是保留的

# 集合
集合即表格，即表
集合存在于数据库中，集合没有固定的结构。
这意味着可以往集合里插入任何的格式。
通常情况下，插入的数据具有关联性
例如可以将
```
{"site":"www.google.com"}
```
数据插入集合中,该文档就会被创建
## 合法的集合名
集合名不能是空字符串
集合名不能含有\0
集合名不能以system开头
创建的集合名不能有保留字，因为系统生成的集合包含有$
## 元数据
数据库的信息存储在集合中，使用了系统命名的空间
## mongodb数据类型
### Objectid
唯一主键包含12位。
```
前 4 个字节表示创建 unix 时间戳,格林尼治时间 UTC 时间，比北京时间晚了 8 个小时
接下来的 3 个字节是机器标识码
紧接的两个字节由进程 id 组成 PID
最后三个字节是随机数
```
类似于这样的
```
5b5f65cc12df191848c2c72f
```
## 字符串
字符串为utf-8编码
## 事件戳
```
前32位是一个 time_t 值（与Unix新纪元相差的秒数）
后32位是在某秒中操作的一个递增的序数
```
## 日期
格林尼治时间
```
> var mydate1 = new Date()
> mydatel
ISODate("2018-07-30T19:26:17.080Z")
>
```
```
> Date()
Tue Jul 31 2018 03:27:07 GMT+0800
>
```
# 连接
mongodb:
# 创建数据库
```
> use Date
switched to db Date
> db
Date
>
```
 查看所有数据库
```
> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB
>
```
由于不存在，需要显示，向其插入数据
```
> db.Date.insert({"name":"ming"});
WriteResult({ "nInserted" : 1 })
> show dbs;
Date    0.000GB
admin   0.000GB
config  0.000GB
local   0.000GB
>
```
# 删除数据库
```
> show dbs;
Date    0.000GB
admin   0.000GB
config  0.000GB
local   0.000GB
> use Date
switched to db Date
> db.dropDatabase()
{ "dropped" : "Date", "ok" : 1 }
>
```
```
> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB
>
```
# 删除集合
```
> show dbs;
admin   0.000GB
config  0.000GB
local   0.000GB
> use local
switched to db local
> show tabls;
2018-07-31T03:34:06.601+0800 E QUERY    [js] Error: don't know how to show [tabls] :
shellHelper.show@src/mongo/shell/utils.js:1043:11
shellHelper@src/mongo/shell/utils.js:755:15
@(shellhelp2):1:1
> show tables;
mycoll
startup_log
> db.mycoll.drop();
true
> show tables;
startup_log
>
```
# 创建集合
```
> show dbs;
admin   0.000GB
config  0.000GB
local   0.000GB
> use local
switched to db local
> db.createCollection("ming");
{ "ok" : 1 }
> show collections;
ming
startup_log
>
```
在MongoDB中，不需要创建集合，在插入一些文档的时候，会自动创建集合
```
> db.mycol2.insert({"name":"ming"});
WriteResult({ "nInserted" : 1 })
> show collections;
ming
mycol2
startup_log
```
# 删除集合
```
> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB
> use local
switched to db local
> show collections;
ming
mycol2
startup_log
> db.mycol2.drop();
true
> show collections;
ming
startup_log
>
```
# 插入文档
即插入row
所有的储存格式是一种JSON格式的
```
> db.col.insert({title:"ming",
... ming:"sdfdf"});
WriteResult({ "nInserted" : 1 })
> db.col.find();
{ "_id" : ObjectId("5b5f6a0ed595bb04cbe14b94"), "title" : "ming", "ming" : "sdfdf" }
>
```
也可以将数据定义为一种变量
都是js的语法。不难，很好上手的
还有一个方法是 insertOne 以及insertMany 分别插入一行或者多行
# MongoDB更新文档
使用update()的方法进行更新
```
> db.col.insert({title:"ming",ming:"ming"});
WriteResult({ "nInserted" : 1 })
> db.col.find();
{ "_id" : ObjectId("5b5f6a0ed595bb04cbe14b94"), "title" : "ming", "ming" : "sdfdf" }
{ "_id" : ObjectId("5b5f6b27d595bb04cbe14b95"), "title" : "ming", "ming" : "ming" }
> db.col.update({title:ming, ming:"ming"},{$set:{"title":"ming",ming:"sferfer"}});
2018-07-31T03:49:28.376+0800 E QUERY    [js] ReferenceError: ming is not defined :
@(shell):1:16
> db.col.update({title:"ming"},{$set:{"title":"seferf"}})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
> db.col.find();
{ "_id" : ObjectId("5b5f6a0ed595bb04cbe14b94"), "title" : "seferf", "ming" : "sdfdf" }
{ "_id" : ObjectId("5b5f6b27d595bb04cbe14b95"), "title" : "ming", "ming" : "ming" }
> db.col.find().pretty();
{
        "_id" : ObjectId("5b5f6a0ed595bb04cbe14b94"),
        "title" : "seferf",
        "ming" : "sdfdf"
}
{
        "_id" : ObjectId("5b5f6b27d595bb04cbe14b95"),
        "title" : "ming",
        "ming" : "ming"
}
>
```
使用save()替换其方法
```
> db.col.find().pretty();
{
        "_id" : ObjectId("5b5f6a0ed595bb04cbe14b94"),
        "title" : "seferf",
        "ming" : "sdfdf"
}
{
        "_id" : ObjectId("5b5f6b27d595bb04cbe14b95"),
        "title" : "ming",
        "ming" : "ming"
}
> db.col.save({_id: ObjectId("5b5f6a0ed595bb04cbe14b94"), title:"1111"});
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
> db.col.find().pretty();
{ "_id" : ObjectId("5b5f6a0ed595bb04cbe14b94"), "title" : "1111" }
{
        "_id" : ObjectId("5b5f6b27d595bb04cbe14b95"),
        "title" : "ming",
        "ming" : "ming"
}
>
```
同样的updateOne()和updateMany()同样可以更新一个或者多个文档
更新的标识仍然是$set
# 删除文档
删除全部文档deleteMany(),删除一个文档deleteOne()
```
> db.col.find().pretty();
{ "_id" : ObjectId("5b5f6a0ed595bb04cbe14b94"), "title" : "1111" }
{
        "_id" : ObjectId("5b5f6b27d595bb04cbe14b95"),
        "title" : "ming",
        "ming" : "ming"
}
> db.col.deleteOne({title:"ming"});
{ "acknowledged" : true, "deletedCount" : 1 }
> db.col.find().pretty();
{ "_id" : ObjectId("5b5f6a0ed595bb04cbe14b94"), "title" : "1111" }
>
```
# 查询文档
```
> show collections;
col
ming
startup_log
> db.ming.find().pretty();
> db.ming.insert(ming:"sfrgedrg");
2018-07-31T04:01:45.661+0800 E QUERY    [js] SyntaxError: missing ) after argument list @(shell):1:19
> db.ming.insert({ming:"sdfrf"});
WriteResult({ "nInserted" : 1 })
> db.ming.find().pretty();
{ "_id" : ObjectId("5b5f6eb7d595bb04cbe14b96"), "ming" : "sdfrf" }
>
```
## and条件
```
> db.ming.find().pretty();
{ "_id" : ObjectId("5b5f6eb7d595bb04cbe14b96"), "ming" : "sdfrf" }
{ "_id" : ObjectId("5b5f6f0ad595bb04cbe14b97"), "name" : "refgerfg" }
{ "_id" : ObjectId("5b5f6f40d595bb04cbe14b98"), "x" : 222, "y" : 44444 }
{ "_id" : ObjectId("5b5f6f50d595bb04cbe14b99"), "x" : 4444, "y" : 22222 }
> db.ming.find({x:222, y:4444});
> db.ming.find({x:222, y:4444}).pretty();
> db.ming.find({x:222, y:44444}).pretty();
{ "_id" : ObjectId("5b5f6f40d595bb04cbe14b98"), "x" : 222, "y" : 44444 }
>
```
直接，即可
## OR条件
使用$or即可
```
> db.ming.find({  $or:[{x:222}, {x:4444}]  });
{ "_id" : ObjectId("5b5f6f40d595bb04cbe14b98"), "x" : 222, "y" : 44444 }
{ "_id" : ObjectId("5b5f6f50d595bb04cbe14b99"), "x" : 4444, "y" : 22222 }
>
```
## 联合使用
sql示例
```
where likes>50 AND (by = 'ming' OR title = 'ming')
```
```
db.ming.find(like: {$gt:50}, $or[{by:"ming"}, {title:"ming"}]);
```
# 条件操作符
```
> $gt
< $lt
>= $gte
<= $lte
```
```
db.col.find({like: {$gt: 100}});
```
类比sql
```
select * from db.col where like > 100;
```








    


  [1]: https://www.ibm.com/developerworks/cn/analytics/library/ba-cn-bigdata-hbase/index.html
  [2]: https://en.wikipedia.org/wiki/FlockDB