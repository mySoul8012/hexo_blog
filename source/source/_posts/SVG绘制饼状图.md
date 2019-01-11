title: SVG绘制饼状图
author: Ming ming
tags: []
categories:
  - 前端
  - SVG
date: 2018-10-15 01:20:00
---
SVG绘制饼状图
昨天学习了基本的SVG，下面是使用SVG绘制饼状图
# 创建SVG空间
创建SVG
> 需要一个document.createElementNS()方法  一个一个setAttribute()方法

编写如下js，将会创建一个svg空间
```
	// 创建一个XML命名空间
	var svgns = "http://www.w3.org/2000/svg";

	// 创建一个SVG元素指定大小和坐标
	var chart = document.createElementNS(svgns, "svg:svg");	// 创建在svgns命名空间里的svg元素
	// 设置节点的属性
	chart.setAttribute("width", "100%");
	chart.setAttribute("width", "300px");
	// 设置视口大小
	chart.setAttribute("viewBox", "0 0 100% 300px");
```

## 关于document.createElementNS 和 document.getElement的区别 以及命名空间
### 命名空间
解决的问题：由于仅仅只有三个字母带来的版本的混乱等等问题。
使用命名空间可以完整的区分一些不同。一些版本上带来的不同
### 关于两者
一个是xml一个是html
一个属于操作xml的内容，一个属于操作html的内容。
### 举个栗子
```
document.createElementNS("p","edition");
```
创建了一个在p命名空间下的edition节点。
使其作为body元素的子节点
```
var e = document.createElementNS("p","edition");
var body = document.getElementsByTagName("body");
body.appendChild(e);
```

# 关于路径path
SVG中的path的d属性的椭圆弧曲线
> 目的是为了绘制饼状图

## 参数
一共有7个参数，以下按照顺序依次解释
## rx ry

```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
	<path d="
		M20 20
		A6 6 0 1 0 40 20
	"/ stroke="#c9d6d5" fill="none">
</svg>
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14/10.png)

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14/11.png)

> 此时有一个起始位置，一个终止位置，一个x轴，一个y轴

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14/12.png)

## 大弧小弧的问题
是使用较长的弧线，还是较短的弧线。
> 一直以为是两个弧线相切晕

## sweep-flag
顺时针，还是逆时针，即选择弧线，以后顺时针旋转还是逆时针旋转。


# 计算弧度
有如下数据

项目 | 百分比
-----|-------
A | 20%
B | 40%
C | 10%
D | 30%

分为四项，然后计算
> 如果数据为原始的楔，可以计算出相应的百分比，

> 复习一下弧度 全部忘光了， 一个完整的圆的弧度为2π，半个圆为π。

计算各自需要的弧度。
20% * 2π 即可得出当前的弧度，依次运算出弧度即可
分别计算如下
项目 | 弧度数
-----|------
A | 0.4π
B | 0.8π
C | 0.2π
D | 0.6π


# 计算圆弧的x和y
x使用sin y使用cos
计算分别的x和y,由于已经拥有r需要确认起点
其中r为10，需要加上圆心坐标（20,20）
项目 | x | y
---|----|---
A | 20 | 20-10=10

> 这里需要注意坐标系的不同

此时
```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
	<path d="
		M20 20
		L20 10
	"/ stroke="#c9d6d5" fill="none">
</svg>
```
如图
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14/13.png)

> 至于为什么要用sin和cos，是由于以12点钟方向为准的。如果以极坐标为准，即x轴正方向为准的，如下![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14/14.png)


接着计算结束坐标
同样的带入计算
项目 | x | y
---|----|---
A | 29 | 16

```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
	<path d="
		M20 20
		L20 10
		A10 10 0 0 1 29 16
	"/ stroke="#c9d6d5" fill="none">
</svg>
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14/15.png)

结束
加Z
```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
	<path d="
		M20 20
		L20 10
		A10 10 0 0 1 29 16 Z
	"/ stroke="#c9d6d5" fill="none">
</svg>
<script>
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14/17.png)

设置画笔宽度，填充颜色，线条颜色
```
stroke="#7a7a7a" fill="#c9d6d5" stroke-width="1"
```
如图
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14/18.png)

完整如下
```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
	<path d="
		M20 20
		L20 10
		A10 10 0 0 1 29 16 Z
	"/ stroke="#7a7a7a" fill="#c9d6d5" stroke-width="1">
</svg>
```
接着重复计算，应该是使用js，将其封装为一个函数，输入圆心坐标，传入数组即可的。

上方最难的在于sin和cos的问题