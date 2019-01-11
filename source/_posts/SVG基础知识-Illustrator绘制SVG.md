title: SVG基础知识  Adobe Illustrator绘制SVG
author: Ming ming
tags: []
categories:
  - 前端
  - SVG
date: 2018-10-13 00:08:00
---

SVG
svg在线编辑器 https://editor.method.ac/
# 多边形
使用的是polygon标签
该标签能创建含有不少于三个边的图形。
如下
```
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<polygon points="0,10 5,2 5,7 10,0"/>
	</svg>
```
效果如下
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/1.png)

其坐标为路径

# 曲线
poliline 为曲线
同样输入的为坐标
此时为了和上一个区分，将file设置为不填充，设置描边为black
```
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<polyline points="0,10 5,2 5,7 10,0" fill="none" stroke="black"/>
	</svg>
```
效果如下
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/2.png)

> 其中 填充为非零绕数原则

# 路径
path类似于笔的路径
其拥有一个属性d，该属性d由下方的单词的首字母组成。
## Moveto
画笔的起点
```
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<path d="M10,100"/>
	</svg>
```
## Lineto
该执行从画笔的起点到位置绘制一条直线
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/3.png)
```
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<path d="M0 0
				 L0 20
				 L40 0
		"/>
	</svg>
```
## Curveto
绘制贝塞尔曲线，由三个参数组成，考虑两个控制点
> 直接选择画板手绘吧，实在看不懂了，貌似缺少了椭圆的一些数学知识

## 总结
绘制一颗心，以下是在网上找的
```
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<path d="M1,3
				 A2,2 0,0,1 5,3
				 A2,2 0,0,1 9,3
				 Q9,6 5,9
				 Q1,6 1,3 Z
		"/>
	</svg>
```
没看懂。。。
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/4.png)

# 文本
text元素
依旧当做图片处理
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/5.png)

```
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<text x="0" y="20" fill="red">Hello world</text>
	</svg>
```
# stroke属性
此为属性，定义任何类型的线条
```
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
		<text x="0" y="20" stroke="black">Hello world</text>
	</svg>
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/6.png)

# 模糊效果
对图片模糊
先引入图片
```
<image x="0" y="0" width="100%" height="300px"   xlink:href="http://127.0.0.1/111.png"/>
```
此时图片显示
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/7.png)

接着定义可复用的组即defs
> defs 标签为可复用的组标签

使用的是file用于存放滤镜的地方
> 使用file标签

使用feGaussianBlur滤镜即模糊滤镜
使用的in的参数为SourceGraphic表示图形作为原始的输入
> 此外还有背景图，通道等

stdDeviation 表示模糊的程度
完整的如下
```
<defs>
	<filter id="f1" x="0" y="0">
		<feGaussianBlur in="SourceGraphic" stdDeviation="15" />
	</filter>
</defs>
```
接着再次使用滤镜
```
<image filter="url(#f1)" x="0" y="0" width="100%" height="100px"   xlink:href="http://127.0.0.1/111.png"/>
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/8.png)
一个模糊
> 效果不错

此外还有阴影渐变，等滤镜，等就太复杂了，设计到矩阵变换等高等数学的内容，自己有心无力。

# 在adobe ai中生成svg
使用adobe ai 生成svg文件
## 创建一个画板
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/9.png)
## 选择字符
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/10.png)

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/11.png)

## 添加字体
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/12.png)

## 转曲
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/13.png)

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/14.png)

## 获取svg代码
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/15.png)

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/16.png)

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/17.png)

## 画出图像
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12/18.png)
代码如下

```
<!DOCTYPE html>
<html>
<head>
	<title>svg页面</title>
</head>
<body>
	<p>这是一个svg</p>

	<!-- svg 图形的命名空间 -->
<svg version="1.1" id="图层_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 1366 768" style="enable-background:new 0 0 1366 768;" xml:space="preserve">
<g>
	<path d="M722.2,346.5c17.1,128.1-27.4,231.2-133.3,309.2c-36.1,26.6-79.1,43.8-123.5,49.7c-109.2,14.4-200.7-14.2-274.5-85.9
		c-62.1-60.1-93.1-133.1-93.1-218.8c0-103.3,45-188.2,135.1-254.6c36.1-26.6,78.9-44.2,123.3-50.2
		c128.7-17.4,232.7,23.8,312.1,123.6C697.2,255.9,716,300.4,722.2,346.5z M709.2,403.7c1.8-83.1-27.7-154-88.5-212.8
		c-58.6-56.5-128-84.7-208.1-84.7l-32.3,66.3l35.2,7.1l27.5-27.5l48.5,3.2l9.7,25.9L472,210.3v17.5l18.1,3.6l8.4-13.6l32-20l-1,13.6
		l12,20.7l-14.2,14.9l9,8.7l-21.3,1.3l8.7,17.5l-46.2,22l7.1,26.2h-14.5l-6.5-25.9l-33.9-0.6l-6.1,10l-13.9-6.5L387,322.1l18.1,21.7
		l-0.6,23.9l19.1,14.2l111.2,12.6l35.2,24.9l-4.2,61.7l-76.6,76.6c-5,5-9.8,18.7-14.5,41.4c-4.5,21.3-6.1,36.5-4.8,45.6l-11.6,13.3
		c-9-17.9-20.8-45.4-35.2-82.4c-3.4-12.7-6.5-28.9-9-48.5c-1.9-16.2-3.9-32.4-5.8-48.8l-48.5-42.7l43-50.7l-17.8-25.5
		c-27.4-5.6-45.1-10.6-53.3-15c-8.2-4.4-22.3-16.8-42.3-37l16.8,32.6l-11.3,4.8l-26.2-49.1l5.2-45.9l-8.1-32.3l-25.2-24.6l-18.4-4.5
		l-16.2,11.3l-17.8,4.5c-49.6,57.3-74.1,123.3-73.4,197.9c0.8,76.3,32.7,151,87.1,204.4c58.1,57,128.4,85.4,210.9,85.4
		c81.9,0,151.8-28.7,209.6-86C675.7,552.8,707.5,479.1,709.2,403.7z"/>
</g>
</svg>
</body>
</html>
```

到此，可以发挥ai的想象啦。包括绘制图形，使用滤镜，画图图标等等，哪怕使用图片导入ai，绘制出矢量图。完美的ai和html的一次结合

# 一个svg.js框架
http://svgjs.com/ 使用该svg.js框架可以快速的操纵svg

