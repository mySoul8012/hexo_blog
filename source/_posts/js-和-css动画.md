title: js 和 css动画
author: Ming ming
tags:
  - js
  - css
  - 动画
categories:
  - 前端
  - js
  - 客户端js
date: 2018-08-11 00:25:00
---
# js和css动画
使用setTimeout()或者setInterval()使用这两个函数定时调用一段代码。这是其原理。
> 目的，重复修改内联样式，达到动画的效果
通过不断的修改达到动画的目的。

通过在相同的时间内构造出一帧帧的内容，然后让其在函数的作用下不断的改变css的值，达到动画的效果
下面将会是用js写css动画

## js写css动画
下面是一个函数 将e转化为相对定位的元素，使得其可以左右移动
第一个参数为元素对象或者元素的id
如果第二个参数是函数，以e为参数，它将在动画结束时调用
第三个参数指定e移动的距离，默认为5像素
第四个参数指定移动多久，默认500毫秒


```
// 将e转化为相对定位的元素，使得其可以左右移动
// 第一个参数为元素对象或者元素的id
// 如果第二个参数是函数，以e为参数，它将在动画结束时调用
// 第三个参数指定e移动的距离，默认为5像素
// 第四个参数指定移动多久，默认500毫秒
function shake(e, oncomplete, distance, time) {
	// 句柄函数
	if (typeof e === "string") e = document.getElemnentById(e);	// 如果传入的是对象的id则获取对象的id，如果传入的为元素（元素为对象）则直接跳过这一句
	if (!time) time = 500;	// 如果time是空值，则直接使用默认值
	if (!distance) distance = 5;	// 如果未指定移动的距离，则默认为5像素

	var originalStyle = e.style.cssText;	// 获取元素e的css样式
	e.style.position = "relative";	// 设置为相对定位
	var start = (new Date()).getTime();	// 设置动画开始的时间,获取一个格林威治时间
	animate();	// 动画开始

	// 函数检查消耗时间，并更新e的位置
	// 如果动画完成，它将e还原为原始状态
	// 否则，将会更新e的位置，安排其自身重新运行
	function animate() {
		var now = (new Date()).getTime();	// 获取现在的时间
		var elapsed = now-start;	// 从开始以来消耗了多长时间
		var fraction = elapsed / time;	// 为总时间的几分之几

		if (fraction < 1) {	// 如果动画未完成
			// 作为动画完成比例的函数，计算e的x位置
			// 使用正弦函数将完成比例乘以4pi
			// 所以，它将来回往返两次
			var x = distance * Math.sin(fraction * 4 * Math.PI);	 // 使用正弦函数实现每秒四帧
			e.style.left = x + "px";

			// 在25毫秒后或在总时间的最后尝试再次运行函数
			// 目的是为了产生每秒40帧动画
			setTimeout(animate, Math.min(25, time-elapsed));	// 使用天花板函数再次调用，再次移动
		}
		else {	// 否则动画完成
			e.style.cssText = originalStyle; // 恢复原始样式
			if (oncomplete) oncomplete(e);	// 产生一个回调函数
		}
	}
}

// 以毫秒级的时间将e从完全不透明淡出到完全透明
// 在调用函数时假设e是完全不透明的
// oncomplete 是一个可选函数，以e为参数，它将在动画结束的时调用
// 如果不指定time，默认为500毫秒
function fadeOut(e, oncomplete, time) {
	if (typeof e === "string") e = document.getElementById(e);
	if (!time) time = 500;

	// 使用Math.sqrt作为一个缓动函数创建动画
	// 非线性函数，一开始淡出的较快，然后逐步的缓慢
	var ease = Math.sqrt;

	var start = (new Date()).getTime();	// 动画开始的时间
	animate();	// 动画开始

	function animate() {
		var elapsed = (new Date()).getTime()-start;	// 消耗的时间
		var fraction = elapsed/time;	// 总时间的几分之几

		if (fraction < 1) {	// 如果动画未完成
			var opacity = 1 - ease(fraction);	// 计算不透明度  即 完成一次变换，开方
			e.style.opacity = String(opacity);	// 设置透明度
			setTimeout(animate, // 进行下一帧
				Math.min(25, time-elapsed));	// 在25毫秒之后或者在总时间的最后再次调用
		}else {
			e.style.opacity = "0";	// 使得e完全透明
			if (oncomplete) oncomplete(e);	// 在结束的时候回调
		}
	}
}
```

# 查询计算出的样式
```
getComputedStyle(e)
```
275个样式。。。O__O "…

# 脚本化css类
除了能脚本化内联样式，同样的也能脚本化css的类
## 移除，添加类
```
e.className = "attention";  // 添加类
e.className = "";   // 移除类
```
## 显示类列表
classList
只读属性，返回元素类属性的实时集合。
```
e.classList()
```
## 脚本化样式表
### 开启和关闭样式表
style和link元素的CSSStyleSheet对象定义了一个在js中可以设置和查询的disabled属性。
> 关于disabled属性，该属性在HTML中不属于规范的一部分，在HTML中不存在，但是，在DOM中存在该属性。在标签中无法设置该属性，但是可以在脚本中设置该属性

如果值为true，样式表关闭，否则样式表打开
```
e.disabled = true;

```
这样样式表即可关闭。

类似的通过以下方式也可
```
document.styleSheets[0].disabled;

```
### 查询，插入与删除样式表规则
CSSStyleSheet对象同样也定义了用来查询，插入和删除样式表规则的api
#### 查询所有样式表内容
```
var firstRule = document.styleSheets[0].cssRules[0];
```

> document.styleSheets[0] 一个只读属性，返回一个该文档的链接或嵌入的样式表

该样式只读，不可进行插入和删除

其中selectorText为css选择器
cssText 为css的文本样式
#### 添加和删除规则
insertRule()和deleteRule()这两种方法，达到添加和删除规则
还有一个addRule()方法
##### insertRule()方法
insertRule()和deleteRule()这两种方法，达到添加和删除规则
```
ss.insertRule(".name {color:blue}", 0);
```
在ss样式表中，在第0条cssRules中添加一条css规则。使得类为name的字体变蓝
如果添加的索引已经存在则不会覆盖，所有的索引加1，然后进行插入
##### deleteRule()方法
删除样式规则
删除上一条插入的样式
```
ss.deleteRule(0);
```
删除第0条规则，样式继续保持从0开始
### 创建新的样式表
这个不难，直接插入一个新的style元素通过innerHTML的方式将其插入新的css内容，或者直接插入link标签，设置添加一个html的属性使用的是 Element.setAttritube()方法，将rel的值设置为stylesheet 然后在用同样的方法添加src属性
> 纯粹的dom 和 bom的操作，不涉及任何样式表的内容