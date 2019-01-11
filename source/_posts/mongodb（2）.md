title: mongodb（2）
author: Ming ming
tags:
  - 数据库
  - mongodb
categories:
  - 前端
  - 数据库
  - mongodb
  - ''
date: 2018-07-31 21:29:00
---
MongoDB
> ps 好多的MongoDB都没有设密码，默认的MongoDB都是不设置密码的，晕

# $type运算符
查询类型用的
获取col集合中的title值为字符串类型的文档
```
db.col.find(title: {$type: 2});
```
# limit 和 skip方法
## limit查询指定的方法
```
> db.ming.find().pretty();
{ "_id" : ObjectId("5b5f6eb7d595bb04cbe14b96"), "ming" : "sdfrf" }
{ "_id" : ObjectId("5b5f6f0ad595bb04cbe14b97"), "name" : "refgerfg" }
{ "_id" : ObjectId("5b5f6f40d595bb04cbe14b98"), "x" : 222, "y" : 44444 }
{ "_id" : ObjectId("5b5f6f50d595bb04cbe14b99"), "x" : 4444, "y" : 22222 }
> db.ming.find().limit(2);
{ "_id" : ObjectId("5b5f6eb7d595bb04cbe14b96"), "ming" : "sdfrf" }
{ "_id" : ObjectId("5b5f6f0ad595bb04cbe14b97"), "name" : "refgerfg" }
```
## skip是跳过第几条数据
# 排序
```
> db.ming.find({}, {ming:1, name:1}).sort({_id:-1});
{ "_id" : ObjectId("5b5f6f50d595bb04cbe14b99") }
{ "_id" : ObjectId("5b5f6f40d595bb04cbe14b98") }
{ "_id" : ObjectId("5b5f6f0ad595bb04cbe14b97"), "name" : "refgerfg" }
{ "_id" : ObjectId("5b5f6eb7d595bb04cbe14b96"), "ming" : "sdfrf" }
> db.ming.find({}.{ming:1, name:1}).sort({id:1});
2018-07-31T19:49:11.007+0800 E QUERY    [js] SyntaxError: missing name after . operator @(shell):1:16
> db.ming.find({}, {ming:1, name:1, x:1, y:1}).sort({ _id:1});
{ "_id" : ObjectId("5b5f6eb7d595bb04cbe14b96"), "ming" : "sdfrf" }
{ "_id" : ObjectId("5b5f6f0ad595bb04cbe14b97"), "name" : "refgerfg" }
{ "_id" : ObjectId("5b5f6f40d595bb04cbe14b98"), "x" : 222, "y" : 44444 }
{ "_id" : ObjectId("5b5f6f50d595bb04cbe14b99"), "x" : 4444, "y" : 22222 }
>
```
# 索引
```
> db.ming.createIndex({ming:1});
{
        "createdCollectionAutomatically" : false,
        "numIndexesBefore" : 1,
        "numIndexesAfter" : 2,
        "ok" : 1
}
>
```
ming字段按照升序创建序列
# 聚合
类似于sql的count()
```
db.ming.aggregate(
		[
			(
				$groupp: {
					_id : "$by-user",
					num_tutorial: {
						$sum: 1
					}
				}
			)
		]
	)
```
按照_id进行分组，然后对分组的文档进行统计，即对分组的文档总和统计。

##  管道
```
> db.ming.aggregate(
... {
... $project : {
... _id:0,
... x:1,
... y:1
... }
... }
... )
{  }
{  }
{ "x" : 222, "y" : 44444 }
{ "x" : 4444, "y" : 22222 }
```
一个值处理完成以后在传给下一个进行处理
即，值经过管道以后，会变成相应的格式
## 随机获取文档
```
db.ming.aggregate(
		[
			{
				$sample: {
					size:1
				}
			}
		]
	)
```
采用聚合，使用$sample来达到目的，其中size为随机获取的条数
## sql随机获取两条记录
```
select * 
from data
order by rand()
limit 2
```
```

mysql> select * from c order by rand() limit 2;
+--------+------------------------+-------+
| cno    | cn                     | hourc |
+--------+------------------------+-------+
| 050192 | 专业英语               | 32    |
| 090112 | 毛泽东思想、邓小平理论 | 48    |
+--------+------------------------+-------+
2 rows in set (0.10 sec)

mysql> select * from c order by rand() limit 2;
+--------+----------------------+-------+
| cno    | cn                   | hourc |
+--------+----------------------+-------+
| 050198 | 计算机网络安全与应用 | 32    |
| 050150 | 计算机组装与维护     | 36    |
+--------+----------------------+-------+
2 rows in set (0.03 sec)

mysql>
```
剩下的复制，看不下去了。
