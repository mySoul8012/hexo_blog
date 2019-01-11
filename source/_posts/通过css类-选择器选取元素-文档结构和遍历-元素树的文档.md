title: 通过css类/选择器选取元素 文档结构和遍历 元素树的文档
author: Ming ming
tags:
  - css
  - 选择器选择元素
  - css类选择元素
  - 文档结构和遍历
  - 元素树的文档
  - ''
categories:
  - 前端
  - js
  - 客户端js
date: 2018-08-06 03:56:00
---
# 通过css类选取元素
html所有的元素拥有class属性，该属性会对元素进行分组，标识为某一组。
js中使用className属性来保存HTML的class的属性值
```
var NodeList = document.getElementById("first")
close.log(NodeList.class)
```
尽管如此，js还定义了一个方法，即一个getElementsByClassName()，是基于class属性值中的标识符来选取成组的文档元素
还有一个类似的getElementsByTagName()的方法也是获取一个组，返回的是一组的内容即NodeList。返回的是类数组。
一个使用getElementsByClassName()的例子
```
// 查找其class属性值中包含warning的所有元素
var warnings = document.getElementsByClassName("warning");
// 查找以log命名并且含有error和fatal类的元素的所有后代
var log = document.getElementById("log");
var fatal = log.getElementByClassName("fatal error"); 	// 先获取id为log，在获取class为fatal error的元素
```
> 一个兼容，浏览器根据！doctype来进行选择怪异模式，和标准模式的，怪异模式是为了向后兼容而存在的，标准模式不是（兼容以及不太重要了，但是还要知道一点，这是ie8的问题，但愿再过几年直接win7也没有了）

# 通过css选择器选择元素
css样式表可以进行选择，这里仅仅是一些常见的css选择器
```
#nav // id = nav 的元素
div // 选择div元素
.warning // 选择class属性为waring的元素

// 基于属性值选取元素
p[lang="fr"]	// 所有语言为fr的元素
*[name="x"]	// 所有包含name="x"的属性的元素

// 将选择器进行组合使用
span.fatal.error 	// 选择class中包含fatal和error的span元素
span[lang="fr"].warning // 所有使用法语，并且class中包含warning的span元素

// 选择器指定文档结构
#log span 	// id 为log元素的后代元素中的所有的span元素
#log > span // id 为log元素的子元素中所有的span元素
body>h1:first-child // <body>的子元素中的第一个<h1>元素

// 选择器组合选择多个或者组合元素
div, #log 	// 所有的div元素，以及id为log的元素属于和关系

// 正则选择器
a[src^="https"]	// 选择src属性为https开头的
a[src$=".pdf"]	// 匹配src属性为.pdf结尾的元素
a[src*="ming"]	// 匹配src中包含ming的元素
```
h5定义了一些选择api用来通过js来选择元素
```
document.querySelector("title")
```
选择title元素
```
document.querySelectorAll("title")
```
会返回一个类数组的 节点列表
```
document.querySelector(":first-line")
```
选择一个伪元素，在css中匹配了节点一部分，而不是实际元素。
其中querySelector只会返回匹配的第一个结果，querySelectorAll将会返回全部结果，返回一个类数组。
```
document.querySelector(":link")
```
返回一个页面上未访问的连接
```
document.querySelectorAll(":visited")
```
选择一个已经访问过的，用来获取用户在该页面的一部分的历史记录
## document.all[]
已经废弃，不在使用，所以不学习

# 文档结构和遍历
一旦从文档中选取了一个元素，将会需要查找文档与之在结构上相关的部分，（即，父元素，子元素，兄弟元素）。温带在概念上为节点对象树。浏览器定义了一个api将会对元素对象树进行遍历
## 作为节点树的文档
Document对象，以及Element对象和文档中表示文本的Text对象都为Node对象，Node对象定义了一下重要的属性。
### parentNode
获取该节点的父节点
### childNode
只读类型数组对象（NodeList对象），它是该节点的子节点的实时表示
### firstChild， lastChild
该节点的子节点中的第一个和最后一个
### nextSibling，previousSibling
该节点的兄弟节点中的前一个和下一个
### nodeType
该节点的类型
> 一些类 继承（基类，父类，超类），派生类，子类
> 这里以c++为栗子 ：基类，父类，超类，指被继承的类，派生类，子类指继承于基类的类，在C++中冒号表示继承，入classA：public：B 表示派生类A从基类B继承而来。派生类包含基类的所有成员，还包括自身的特有成员，由于继承关系的存在，派生类和派生类对象访问基类中的成员就像访问自己的成员一样。可以直接使用，但是派生类，仍旧无法访问基类中的私有成员。C++派生类可以同时从多个基类继承，java不允许多重继承，当继承多个基类的时候，使用，运算符将基类进行分开。

#### Element
Element是一个通用的基类，所有的Document都继承自Element
例如
```
<p>
```
属于一个由Element基类继承的Document的一个节点

#### text节点
文字内容，即匿名文字所成的节点。
#### Comment节点
属于注释的节点
```
<!-- 这是注释内容 -->
```
#### Document 节点
一个已经加载好的网页，并通过入口来操作网页的内容
#### DocumentType节点
一个声明节点
#### DocumentFragment 节点
表示一个没有父级文件的最小文档对象。它被当做一个轻量版的 Document 使用
### nodeValue
text节点或者Comment节点文本内容
### nodeName
元素的标签名，以大写输出
### 一个栗子
```
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
hello word
</body>
</html>
```
控制台输入
```
document.childNodes[1].childNodes[2].childNode[0]
```
返回
```
#text
```
表示
```
<body>之前的导致换行符
```
该html
```
<!DOCTYPE html><html><head><title></title></head>
<body>hello word</body></html>
```
继续重新加载，重新输入
```
document.childNodes[1].childNodes[1]
#text
```
继续去掉唯一的换行符
```
<!DOCTYPE html><html><head><title></title></head><body>hello word</body></html>
```
继续在控制台输入
```
document.childNodes[1].childNodes[1]
<body style>​…​</body>​
```
返回body
说明是换行符的问题导致
https://stackoverflow.com/questions/45614337/what-causes-childnodes-to-return-text-instead-of-div
https://stackoverflow.com/questions/21357004/what-are-html-dom-text-elements


# 作为元素树的文档
将文档看成Element对象树，忽视部分文档，text和comment文档（回车，空格，以及注释节点）
## Element的children属性
第一部分是Element（通用基类）的children属性，类似于childNodes属于一个NodeList对象，不同的是children列表只包含Element对象，text和Comment节点没有children属性，任何的Element的parentNode（父节点）都是另一个Element，或者是树根的Document节点
## Element的属性
firstElementChild，lastElementChild
类似firstChild和lastChild，只代表子Element
nextElementSibling，previousElementSibling
类似的nextSibling和previousSibling 代表兄弟节点
childElementCount
子元素的数量，和children。length的值相等
