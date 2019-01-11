title: 'DOM概述 选取文档元素  '
author: Ming ming
tags:
  - DOM
  - 选取文档元素
categories:
  - 前端
  - js
  - 客户端js
date: 2018-08-05 21:34:00
---
脚本化文档
客户端js的存在使得静态的html文档变成了可交付式的web应用
# DOM概述
文档对象（DOM）是表示和操作html和xml文档内容的基础api。
```
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>这是标题</title>
</head>
<body>
	<h1>这是标题</h1>
	<p>这是内容</p>
</body>
</html>
```
将会有一个树状图
我懒就不写了。
# 选取文档元素
## 通过ID选取元素
举一个栗子，通过ID查找多个元素
```
/*
 *	函数接收任意多的字符串参数
 *	每个参数将当做元素的id传给document.getElementById()
 *	返回一个对象，它把这些id映射到对应的Element对象
 *	如果一个id未定义，将会抛出一个Error对象
 */
function getElements(/*ids...*/) {
	var elements = {};	// 开始是一个空map映射对象
	for (var i = 0; i < arguments.length; i++) {	// 循环每个参数
		var id = arguments[i];
		var elt = document.getElementById(id);	// 进行查找元素
		if (elt == null)
			throw new Error("No element with id:" + id);	// 抛出异常
		elements[id] = elt;	// 完成映射关系
	};
	return elements;
};
```
## 通过名字选取元素
有些html标签会有name元素，区别于id，name属性的值不必是唯一的，多个元素可能存在相同的名字。
举一个栗子
```
var radiobuttons = document.getElementsByname("favorite_cole");

```
即可以获取name的值为
```
favorite_cole
```
的元素。
## 通过标签名选取元素
Document 对象的getElementByTagName()方法可用来选取指定类型。所有的html元素。
举一个栗子，选取所有包含span元素的对象
```
var spans = document.getElementsByTagName("h3")
```
将会返回一个NodeList对象
```
var firstspara = document.getElementsByTagName("p")   // 选取所有的p元素的，返回一个所有p元素的对象

console.log(firstspara[0]); // 返回第一个元素
```

查找第一个p元素里的span元素
```
var firstpara = document.getElementsByTagName("p");
firstpara[0].getElementsByTagName("span");
```
这样能获取第一个p元素里的所有的span元素
另外document还有两个属性，分别是特殊的body，以及head元素，这两个元素如果源代码未包含，其浏览器会隐式的创建他们，以及documentElement指代文档的根元素。html中，总是为html元素

## 节点列表和html集合
getElementsByName()以及getElementsByTagName()都会返回NodeList对象
> Nodelist 对象 ： 属于只读的类数组对象（拥有数组的属性，并且其length会有js解释器自动进行维护，并且可以进行折断）可以对NodeList类数组对象可以进行循环迭代，得出所有的节点。

对NodeLsit对象进行循环迭代
```
// 实现一个将所有的image进行全部隐藏
for (var i = 0; i < document.getElementsByTagName("img").length; i++ ) {
	document.getElementsByTagName("img")[0].style.display = "none";		// 设置其css为的display的属性值为none
};

```
返回值为设置的style 为none

不能再类数组上调用数组的方法，不过可以通过原型链来完成间接的调用
```
var content = Array.prototype.map.call(document.getElementsByTagName("p"),
	(e) => {
		return e.innerHTML;	// 返回序列化过的html代码，该方法继承自Element，所有Document对象的方法都基于其，因为同样是document继承来的，所以具有innerHTML方法
	}
)  // 创建一个数组，并把该数组的元素传入回调函数中进行处理
```
注意，保存的不是快照，伴随着html中的DOM的更新，属于实时操作的，这一点灰常有用
如果在一个没有div中的有一个该方法，如果页面动态加载进的div元素，其中的length会自动更新加1，也会自动成为NodeLsit成员，
迭代删除一个元素
```
var snapshot = Array.prototype.slice.call(document.getElementsByTagName("img"), 0)	// 使用浅拷贝，生成副本对副本进行操作
```
再次使用
```
Array.prototype.splice()
```
执行删除操作，但是其真正的节点不会删除，因为是一个副本
下面是通过css选取元素