title: 'css3 渐变 '
author: Ming ming
tags:
  - css3
  - 渐变
categories:
  - 前端
  - css
date: 2018-08-09 04:17:00
---
css3
ps: css越来越真正的像一门语言了，css已经有变量了，刚刚看到文档中。一个实验性质的功能。
# 渐变
渐变分为两种渐变，一种是线性渐变，一种是径向渐变
## 线性渐变
线性渐变为向上，向下，向左，向右两种渐变方式。
### linear-gradient()函数
此为css的一个函数。线性渐变由一个轴即梯度线构成。其上的每个点具有两种或多种颜色。其轴上的每个点具有独立的颜色。为了构建出平滑的渐变，该函数还会构建一系列的着色线。每一条着色线的颜色还会取决于与之垂直相交的渐变线上的色点。
<img src="https://www.iming.info/images/pasted-19.png">
```
// 渐变轴45度，重蓝色到红色
linear-gradient(45deg, blue, red);
```
<img src="https://www.iming.info/images/pasted-20.png">
```
// 从右下到左上，蓝色渐变到红色
linear-gradient(to left top, blue, red);
```

<img src="https://www.iming.info/images/pasted-21.png">
```
// 从下到上，从蓝色开始渐变、到高度40%位置是绿色渐变开始、最后以红色结束 
linear-gradient(0deg, blue, green 40%, red);
```

> ps 透明度为rgba的最后一个参数

## 径向渐变
径向渐变由其中心点，边缘形状，轮廓，及其位置，和色值结束点组成。
径向渐变由椭圆不断的组成
<img src="https://www.iming.info/images/pasted-22.png">
### 第一个参数
第一个参数一般都可省，
#### closest-side
<img src="https://www.iming.info/images/pasted-23.png">
#### closest-corner
<img src="https://www.iming.info/images/pasted-24.png">
#### closest-side
<img src="https://www.iming.info/images/pasted-25.png">
#### farthest-corner
<img src="https://www.iming.info/images/pasted-26.png">
#### circle at 百分比
<img src="https://www.iming.info/images/pasted-27.png">
#### 分开写
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F07%2F24%2F1.png">
#### 百分号
<img src="https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image%2F2018%2F07%2F24%2F22.png">