title: window对象（一）
author: Ming ming
tags:
  - 计时器
  - 定位导航
  - url解析
  - 浏览历史
  - 对话框
  - 消息推送
  - ''
categories:
  - 前端
  - js
  - 客户端js
date: 2018-08-04 01:25:00
---
window对象
# 计时器
一个jQuery作者的写的关于定时器解释，记的顺手订阅一下。John Resig，jQuery之父
https://johnresig.com/blog/how-javascript-timers-work/
如果时间为0，则会放入队列之中，由队列进行调用，即生产者-消费者模型
一个栗子
```
function invoke(f, start, interval, end) {
	if (!start) start = 0;	// 默认设置为 0 毫秒,如果传入有值，将会不进行设置
	if (arguments.length <= 2) {	// 如果没有传入end的值
		setTimeout(f, start);	// 函数f将会在start秒后调用
	} else {	// 如果传入的值有end
		setTimeout(repeat, start);	// 将会在start毫秒后执行repeat
		function repeat() {	// 开始定义repeat函数
			var h = setInterval(f, interval)	// 在interval循环调用f
			// 在end毫秒以后停止调用。
			if (end) {	// 再次判断end是否存在
				setTimeout(() => {
					clearInterval(h);	// 清除定时任务
				}, end);
			}
		}
	}
}
```
# 浏览器定位和导航
window对象的location属性引用的是Location对象的。
https://developer.mozilla.org/zh-CN/docs/Web/API/Location
因为存在引用关系，下列等式总是成立
```
location === document.location;
true
```
## url解析
提取url搜索字符串中的参数
```
/*
 *	这个函数解析url查询串中的name=value字符串
 *	它将 name=value 对储存在一个对象的属性中，并返回该对象
 *	使用方法
 *
 *	var args = urlArgs();	// 调用定义好的函数，进行解析
 *  var q = args.q || "";	// 一个判断，如果参数存在使用参数，否则使用""
 *
 */

function urlArgs() {
	var args = {};
	var query = location.search.substring(1); 	// 获得问号后面的内容
	var pairs = query.split("&");	// 将字符串进行分割 按照& 即进行分项
	for(var i = 0; i < pairs.length; i++){	// 进行依次遍历
		var pos = pairs[i].indexOf('=');	// 进行查找是否有= 没有返回-1 有返回等号所在的索引
		if (pos == -1) {	// 如果没有 ‘=’
			continue;	// 跳过循环
		};
		var name = pairs[i].substring(0, pos);	// 因为后一个是不包括，所以返回=前面的内容
		var value = pairs[i].substring(pos+1);	// 返回等号后的结果
		args[name] = value;	// 对键值对进行存储 
	};
	return args;	// 返回数组
};
```
## 载入新的文档
```
// 更改location属性使得网页跳转
location = "http://www.iming.info/"

// 将相对url赋值给location达到对当前url解析的目的
location = "page2.html";

// 跳转到文档的顶部，跳转页面向上
location = "#top"	// 如果 #top没有定义

// 字符串拼接url
location.search = "?page" + (pagenum + 1);	// 加载一个新文档，更改href的值也同理
location.hash = pagenum;	// 将会在当前文档跳转到id为pagenum的标注点
```
## 浏览历史
window对象的history属性引用该窗口的history对象
脚本不能访问已经保存的url
length表示浏览列表中历史记录
注意：仅仅是当前标签页的浏览历史记录，因为每开一个标签相当于创建了一个新的线程（有些时候浏览器会自动将线程合并）所以相互之间的js线程为独立的，不能相互访问。
```
// 单击浏览器的后退按钮2次、
history.go(-2)

// 单击浏览器的前进按钮2次
history.go(2);
```
由于ajax的技术的存在，导致会发生这种事情。
# 浏览器和屏幕信息
## navigator对象
该对象起这个名字是为了纪念那遥远的网景浏览器，(*@ο@*) 
知道了，长见识了，网景浏览器英文名；Netscape Navigator 一个时代。可惜自己错过了。唉~
> ps 是滴 google chromem已经10年了。2008年，到2018年，整整10年

可以根据
```
navigator.userAgent
```
获取当前浏览器的一些信息。
例如
```
navigator.userAgent
"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0"
```
这是基于Mozilla开源项目的Firefox的浏览器，其内核为Gecko 版本号为20100101 火狐浏览器版本号为61.0， 基于的Mozilla的项目开源版本号为5.0
> Mozilla 是由网景创立，不过现在伴随着网景的彻底从历史上消失，现在这个社区成为一个开源组织。属于Mozilla基金会。已经整整20年了

历史 https://en.wikipedia.org/wiki/History_of_the_Internet

```
navigator.userAgent
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75 Safari/537.36"
```
表明浏览器四AppleWebkit内核的版本为537.36  为chrome浏览器，版本为68。0  safari 为 537.36

## screen对象
window对象引用的是screen对象
```
Screen { availWidth: 1378, availHeight: 900, width: 1440, height: 900, colorDepth: 24, pixelDepth: 24, top: 0, left: 0, availTop: 0, availLeft: 0 }
```
```
Screen {availWidth: 1378, availHeight: 900, width: 1440, height: 900, colorDepth: 24, …}
availHeight
:
900
availLeft
:
0
availTop
:
0
availWidth
:
1378
colorDepth
:
24
height
:
900
orientation
:
ScreenOrientation {angle: 0, type: "landscape-primary", onchange: null}
pixelDepth
:
24
width
:
1440
```
能够得到当前浏览器的一些相关信息，例如屏幕的大小，分辨率等


# 对话框
## 一个桌面消息推送
谷歌浏览器支持桌面消息推送（套壳浏览器也支持，都是一个内核的，无所谓支持不支持）
https://developers.google.com/web/fundamentals/codelabs/push-notifications/?hl=zh-cn
https://crxdoc-zh.appspot.com/apps/inform_users
github 源码 https://github.com/GoogleChromeLabs/web-push-codelab
可以实现桌面消息推送， 
以后会专门写一个推送，目前比较好奇这个推送的过程。看着也不算太难
以及chrome的博客 https://developer.chrome.com
一个自发组织的chrome应用扩展程序的 
 不过这都貌似过时了。
github https://github.com/GoogleChrome 
以及 https://developers.google.com/web/fundamentals/
这也算是一个教程的地方了
以及chromium 博客 https://blog.chromium.org/  基本上套壳浏览器的内核都是基于chromium的
以及
https://blog.google/products/chrome/
用消息推送能够实现本地的消息推送，基于系统层面。
安卓能基于chrome浏览器，现在对移动端不熟。以后这也是需要弥补的一个地方、
## alert confirm prompt
alert 只有一个确定按钮，用于警告等内容
confirm 一个可选的消息，以及两个按钮，在浏览器的地址栏正中央的下方弹出，chromer如此
prompt 显示一个对话框，用于提示用于输入。
举一个栗子
```
do {
	var name = prompt("what is your name?");	// 弹出对话框，输入名字
	var correct = confirm("you entered " + name + "\n" + "Click Okay to proceed or Cancel to re-eenter");	// 弹出一个对话框	,将会返回一个布尔值
} while(!correct)
alert("hello, " + name);	// 弹出一个警告框
```
其中confirm()以及prompt()会产生阻塞。即，在用户关掉的之前，不会返回内容，即意味着在弹出一个对话框前，代码会停止运行。如果正在载入文档，会停止载入，等待用户输入。alert()也是如此，也会产生阻塞
还有一个为showMondalDialog()，会显示一个包含html的格式的模拟对话框。可以给其传入参数，然后从对话框返回值。
注意一点
```
该特性已经从 Web 标准中删除，虽然一些浏览器目前仍然支持它，但也许会在未来的某个时间停止支持，请尽量不要使用该特性。
```
好吧。这个已经废弃，那就不学了

## 错误处理
oneror 已经废弃

# 博客
www.iming.info