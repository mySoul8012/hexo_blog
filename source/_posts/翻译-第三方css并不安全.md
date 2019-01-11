title: 第三方css并不安全
author: Ming ming
tags: []
categories:
  - 翻译
  - 前端
  - 安全
  - ''
date: 2018-09-22 13:25:00
---
 翻译一篇文章 标题，第三方的css并不安全
> 文章源地址 https://jakearchibald.com/2018/third-party-css-is-not-safe/

前几天，有很多关于css的键盘记录器的相关的消息。
> css 键盘记录器 https://github.com/maxchehab/CSS-Keylogging

很多人要求浏览器进行修复，也有些人发现影响了类似React框架的内构建的网站。

# 第三方图像
```
<img  src = “https://example.com/kitten.jpg” >
```
如果包括三方的代码，网站examp.com可以通过删除图片达到返回404的目的，让网站出现显示不全的问题，或者是直接替换原图片文件。

但是，图像的影响仅仅限于元素本身的内容框，可以尝试向用户解释这里有一些内容是来自路 example.com的，如果该图片出现问题，那么不是本身网站的错误，是来自其引用图片网站的错误。并且还要不能影响密码字段之类的内容

# 第三方脚本
```
<script src = “https://example.com/script.js” > </ script>
```
于图片相比，第三方脚本对网页有更多的控制权，如果包括上述内容，该脚本能够完全的控制网址，即能做到
1. 读取/更改页面的内容
2. 监控用户的交互
3. 运行计算量很大的代码 如 门罗币挖矿
4. 使用用户的cookie向服务器发送请求，然后盗取cookie
5. 读取/更改原始的储存
6. 任何它们想做的事情，都可以做到

原始储存非常重要，如果脚本干扰了indexedDB或缓存储存的api，即使您删除了脚本，那么攻击依旧会发生。
> 注，由于浏览器的缓存机制的存在会导致恶意脚本依旧在用户的浏览器上运行。

如果您包含来自其他来源的的脚本，必须确保其安全的问题。

如果遇到恶意脚本，必须使用Clear-Site-Data http标头，用来清除用户浏览器中缓存的站点数据

# 第三方的css
```
<link  rel = “stylesheet”  href = “https://example.com/style.css” >

```
第三方的css相比较脚本更接近于图像，和脚本类似，同样是作用于整个的页面。它可以做到
1. 删除/添加/修改页面内容
2. 根据页面内容发出请求
3. 响应许多用户的交互
css不能修改原始储存，你能在css中构建矿工。（即，门罗币矿工），但是恶意的css仍然会造成很大的破坏

## 键盘记录器
从一个引起很多关注的那个开始
```
input[type="password"][value$="p"] {
  background: url('/password?p');
}
```
在上方中 password?p ，如果输入的value属性结束，将会触发请求 p，这样会造成捕获了大量的数据。

value在默认的情况下，浏览器不会将用户输入的值储存在属性中，因此攻击取决于同步这些值的内容，即React

为了缓解这种情况，React正在寻找另外一种同步密码字段的方法，或者浏览器可以限制与密码字段的value属性匹配的选择器，但是，这并没有什么用处

如果React切换到使用该 data-value属性，则当前的暂缓机制（当前的对于安全的应对措施）将会完全的实效，如果站点将输入更改为 
```
type = "text"
```
以方便用户可以看到他们正在键入的内容，那么作用也实效，如果站点 
```
<butter-passworld-input>
```
哪里创建并公开该值 作为属性，那么机制也将实效

此外，还有很多其他基于css的攻击

## 内容将会消失
```
body  { 
  display ： none ; 
} 

html :: after  { 
  content ： 'HTTP 500 Server Error' ; 
}
```
上方为一个很极端的栗子，但是可以想象一下，如果第三方为你的一小部分用户做了这种事情，那么将会出现很大的问题

更有可能会出现黑客删除购买按钮，或者重新排列内容中的段落

## 对内容添加
```
.price-value :: before  { 
  content ： '1' ; 
}
```
使用这种方法对网页中的内容进行修改

## 对网页中的内容进行移动
```
.delete-everything-button {
  opacity: 0;
  position: absolute;
  top: 500px;
  left: 300px;
}
```
拿那个做很严重事情的按钮，让其看不见，然后将其放在用户可能点击的东西上、

值得庆幸的是，如果按钮执行非常严重的操作，该网站可能会首先显示确认对话框，没有关系，可以继续使用更多的css来诱骗用户单击是的，我确定，按钮，而不是哦上帝没有按钮。
可以想象一下，如果浏览器没有减轻键盘记录的伎俩，攻击者可以在页面上输入非密码文本输入。然后将其放在密码输入上。
> 注，使用覆盖的方式完成。

## 阅读属性
除此之外，在html属性中还会有其他私有内容
```
<input  type = “hidden”  name = “csrf”  value = “1687594325” > 
<img  src = “/ avatars / samanthasmith83.jpg” > 
<iframe  src = “// cool-maps-service / show？st-pancras- london“ > </ iframe> 
<img  src = ”/ gender-icons / female.png“ > 
<div  class = ”banner users-birthday-today“ > </ div>
```
这些都能作为css选择器为目标，并且可以作为结果发出请求

## 监控用户和网页的互动
```
.login-button:hover {
  background: url('/login-button-hover');
}

.login-button:active {
  background: url('/login-button-active');
}
```
可以将悬停和激活发送回服务器，使用css，可以了解用户和页面的互动操作

## 阅读文字
```
@font-face {
  font-family: blah;
  src: url('/page-contains-q') format('woff');
  unicode-range: U+71;
}

html {
  font-family: blah, sans-serif;
}
```
在这种情况下，如果页面包含文字，将会发送请求q，

#  第三方内容不安全
这只是我所知道的一些技巧，我相信还有会更多。
第三方内容在其沙箱中具有很高的影响力，图像或沙盒iframe 具有非常小的沙箱，但脚本和样式的范围限定在您的页面，甚至整个原点。
如果您担心用户欺骗您的网站加载第三方资源，那么您可以使用csp作为安全网，用来限制从中获取图像，脚本和样式的位置。
> csp 内容安全策略，是为了缓解很大一部分潜在的跨站脚本问题，浏览器的扩展程序系统引入了内容安全策略，以白名单的机制对网站加载或执行的资源起作用。在HTTP的头部

您还可以使用资源完整性，来确保脚本/样式的内容与特定的哈希匹配。否则将会无法执行

如果您对更多内容感兴趣，包括滚动条技巧的更多细节，请查看Mathias Bynens的2014年演讲，Mike West的2013年演讲，或Mario Heiderich等人的2012年论文（PDF）。但这不是最新的
> https://vimeo.com/100264064#t=1290s
> https://www.youtube.com/watch?v=eb3suf4REyI
> http://www.nds.rub.de/media/emma/veroeffentlichungen/2012/08/16/scriptlessAttacks-ccs2012.pdf