title: SVG可伸缩的矢量图形
author: Ming ming
tags: []
categories:
  - 前端
  - SVG
date: 2018-10-09 23:13:00
---
SVG可伸缩的矢量图形
SVG是对画该图形时的一些路径，做出精准的，必要的与分辨率无关的一种描述。即对矢量图的描述
在此安利一个svg绘图的网址，可以直接手动绘图，然后生成相关的svg描述，即可实现图片
> 属于所见所得的方式

有两种方式在Adobe系列软件中Illustrator可以直接生成svg的相关代码，还有相关的在线转换网站，可以实现将图片和svg的相互转换，https://www.aconvert.com/cn/format/svg/ 以及 https://convertio.co/zh/svg-converter/


以及一个在线的svg绘图网站http://www.zuohaotu.com/svg/  

svg可以支持任意的曲线，文本，动画效果，还能整合js脚本实现。

其中还有一个绘图程序 https://inkscape.org/en/ 可以绘制矢量图

# 在HTML中嵌入SVG
```
<!DOCTYPE html>
<html>
<head>
	<title>svg页面</title>
</head>
<body>
	<p>这是一个svg</p>

	<!-- svg 图形的命名空间 -->
	<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
        <!-- 这里填写svg的相关代码 -->		
	</svg>
</body>
</html>
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/09/1.png)

# 矩形
下面创建矩形
```
<!DOCTYPE html>
<html>
<head>
	<title>svg页面</title>
</head>
<body>
	<p>这是一个svg</p>

	<!-- svg 图形的命名空间 -->
	<svg xmlns="http://www.w3.org/2000/svg">
		<rect width="300" height="100"
			style="fill:rgb(0,0,255);stroke-width:1;stroke:rgb(0,0,0)"
		/>
	</svg>
</body>
</html>
```
使用的是rect标签，创建一个矩形。
width为宽度，height为高度
style为样式，fill代表颜色为蓝色，宽度为1，边框为黑色
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/09/2.png)

## 圆角矩形
```
<!DOCTYPE html>
<html>
<head>
	<title>svg页面</title>
</head>
<body>
	<p>这是一个svg</p>

	<!-- svg 图形的命名空间 -->
	<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500">
		<rect x="10" y="10" width="300" height="100" rx="50" ry="50"/>
	</svg>
</body>
</html>
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/09/3.png)

## 不透明矩形
```
<!DOCTYPE html>
<html>
<head>
	<title>svg页面</title>
</head>
<body>
	<p>这是一个svg</p>

	<!-- svg 图形的命名空间 -->
	<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500">
		<rect x="10" y="10" width="300" height="100" rx="50" ry="50"  fill-opacity="0.5"/>
	</svg>
</body>
</html>
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/09/4.png)

# 圆形
circle元素可以创建一个圆形
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/09/5.png)

```
<!DOCTYPE html>
<html>
<head>
	<title>svg页面</title>
</head>
<body>
	<p>这是一个svg</p>

	<!-- svg 图形的命名空间 -->
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<circle cx="25" cy="25" r="5"/>
	</svg>
</body>
</html>
```
实现了一个圆形

# 椭圆
使用的是ellipse
```
<!DOCTYPE html>
<html>
<head>
	<title>svg页面</title>
</head>
<body>
	<p>这是一个svg</p>

	<!-- svg 图形的命名空间 -->
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<ellipse cx="10" cy="5" rx="10" ry="5"/>
	</svg>
</body>
</html>
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/09/6.png)

# 直线
使用line绘制
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/09/7.png)

```
<!DOCTYPE html>
<html>
<head>
	<title>svg页面</title>
</head>
<body>
	<p>这是一个svg</p>

	<!-- svg 图形的命名空间 -->
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<line x1="0" y1="8" x2="10" y2="20" stroke="black"/>
	</svg>
</body>
</html>
```