title: css3过渡
author: Ming ming
tags:
  - css3
  - 过渡
categories:
  - 前端
  - css
  - ''
date: 2018-08-10 00:48:00
---
css过渡
css过渡为一种状态到另外一种状态的变换
# transition 过渡
transition 为一个简写属性，是一个transition-property （定义过渡的属性的名称）以及 transition-duration （定义过渡属性的所需动画的时间）和 transition-timing-function （描述中间值如何计算的） 以及 transition-delay （描述过渡效果开始作用之前需要等待的时间）

## transition-property
transition-property 定义过渡属性的名称
即指定引用过渡属性的名称
> 例如要对width属性应用过渡动画，则其该属性的值为width。规定的属性动画值有在这 https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_animated_properties   该列表列出来的属性为可动画的属性。


<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F11.gif">

其css如下
```
div {
	width:300px;
	height:400px;
	background:#698771;
}
div:hover {
	background:#ededed;
	transition-property:background;
}
```
html 如下
```
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="./index.css" type="text/css">
	<title>form表单</title>
</head>
<body>
	<div></div>
	<script src="./index.js"></script>
</body>
</html>
```
由于没有设置过渡的时间，所以效果不大
## transition-duration
transition-duration这是一个过渡时间的设置。
设置过渡的时间为3s
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F12.gif">
非常明显出现过渡的效果
下面是css
```
div {
	width:300px;
	height:400px;
	background:#698771;
	margin:auto;
	transition-property:background;
	transition-duration:3s;
}
div:hover {
	background:#ededed;
	transition-property:background;
	transition-duration:3s;
}
```
下面是html
```
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="./index.css" type="text/css">
	<title>form表单</title>
</head>
<body>
	<div></div>
	<script src="./index.js"></script>
</body>
</html>
```
## transition-timing-function
该属性用于描述属性的中间值。即该两个状态变化的过渡曲线
### single-transition-timing-function （一个过渡函数 ）
其取值是一个三次方的贝塞尔曲线的值。填入一个三个值，根据贝塞尔曲线 
参考 https://zh.wikipedia.org/wiki/%E8%B2%9D%E8%8C%B2%E6%9B%B2%E7%B7%9A
http://www.html-js.com/article/1628
在adobe系列的软件中ai，ps等都应有了贝塞尔曲线，css中也有贝塞尔曲函数。
获取一些常见的贝塞尔曲线
github https://github.com/ai/easings.net
https://easings.net/zh-cn
根据这个选择一些常见的贝塞尔曲线。
除了贝塞尔曲线以外还有一些其他的函数，依次说明
### 贝塞尔曲线
#### 一个栗子
选择一个贝塞尔曲线
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F13.png">

然后html如下
```
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="./index.css" type="text/css">
	<title>form表单</title>
</head>
<body>
	<div></div>
	<script src="./index.js"></script>
</body>
</html>
```
其css如下
```
div {
	width:300px;
	height:400px;
	background:#698771;
	margin:auto;
	transition-property:width;
	transition-duration:3s;
	trasition-timing-function: cubic-bezier(0.645, 0.045, 0.355, 1);
}
div:hover {
	width:100%;
	transition-property:width;
	transition-duration:3s;
	transition-timing-function: cubic-bezier(0.645, 0.045, 0.355, 1);
}
```
其效果如下
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F14.gif">

#### 大概解释一下
cubic-bezier为一个时序功能的类，该类有四个参数。分别有四个点，对应于三次方的贝塞尔曲线。
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F14.png">
p0和p1为起点和终点，其中p0和p1两个值都是固定的分别为(0,0)和(1， 1)这是两个起始值和终止值，其中传入该参数的为p1和p2的值，（p1和p2的值只能在[0,1]的范围内，否则css将会忽视该属性的值）
### 阶跃函数 / 赫维赛德函数 / Step function
steps()定义了一个阶跃函数
定义，如果实数域上的某个函数可以用半开区间上的指示函数的有限的线性组合表示，其为阶跃函数
> 即，阶跃函数为有限段的分段常数函数的 组合

参考; https://en.wikipedia.org/wiki/Step_function


#### 举栗子
steps(2, start)
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F15.png">

start(4, end)
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F16.png">

> start 表示左连续函数 在动画开始时发生第一步
> end 表示右连续函数 在动画结束时发生最后一步 为默认值

同样的该函数仅仅在[0, 1]区间内
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F17.gif">

css
```
div {
	width:300px;
	height:400px;
	background:#698771;
	margin:auto;
	transition-property:width;
	transition-duration:3s;
}
div:hover {
	width:100%;
	transition-property:width;
	transition-duration:3s;
	transition-timing-function: steps(5, end);
}
```
html
```
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="./index.css" type="text/css">
	<title>form表单</title>
</head>
<body>
	<div></div>
	<script src="./index.js"></script>
</body>
</html>
```
### 帧函数 
https://www.w3.org/TR/css-timing-1/#frames-timing-functions
同理根据名字可知为一帧一帧的
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F18.png">

```
div {
	width:300px;
	height:400px;
	background:#698771;
	margin:auto;
	transition-property:width;
	transition-duration:3s;
}
div:hover {
	width:100%;
	transition-property:width;
	transition-duration:3s;
	transition-timing-function: frames(10);
}
```
由于是草案，暂时不可用

### 一些定义的关键字
#### linner 
一个一次函数，经过原点恒定的速率运动
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F19.png">

#### ease
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F20.png">
动画开始缓慢，急剧加速，然后逐渐减慢

#### ease-in
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F21.png">
动画开始缓慢，然后逐渐加速直到结束，此时它突然停止。

#### ease-in-out
动画开始缓慢，加速，然后减速到最后。
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F22.png">

#### ease-out
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F23.png">
动画突然开始，然后逐渐减慢到最后。

#### step-start
动画会立即跳转到最终状态，直到结束。
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F24.png">

#### step-end
动画保持其初始状态直到结束，此时它直接跳转到最终状态。
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F25.png">

#### transition-delay
规定过渡效果开始作用之前需要等待的时间。
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F26.gif">

css如下
```
div {
	width:300px;
	height:400px;
	background:#698771;
	margin:auto;
	transition-property:width;
	transition-duration:3s;
}
div:hover {
	width:80%;
	transition-property:width;
	transition-duration:3s;
	transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
	transition-delay: 2s;
}
```
# 过渡总写
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F08%2F09%2F27.gif">
```
div {
	width:300px;
	height:400px;
	background:#698771;
	margin:auto;
	transition-property:width;
	transition-duration:3s;
}
div:hover {
	width:80%;
	background:#e8e899;
	transform:width 2s cubic-bezier(0.95, 0.05, 0.795, 0.035) .5s, background 6s cubic-bezier(0.95, 0.05, 0.795, 0.035) 5s;
}
```