title: 脚本化HTTP 取得响应 指定请求
author: Ming ming
tags:
  - 脚本化HTTP
  - 取得响应
  - 指定请求
categories:
  - 前端
  - js
  - 客户端js
date: 2018-08-15 05:29:00
---
脚本化HTTP
下面将会用js代码操纵HTTP
下面将会说明在没有导致web浏览器重新加载任何窗口或者窗体的情况下，脚本实现web浏览器和服务器之间的通信。
ajax：为一种找早起避免页面重载而动态更新页面的方式，不过现在是直接数据驱动，或者类似于vue的单页应用
comet：这个和ajax正好相反，为推送消息到web浏览器端
> ps；ajax和comet都为一个美国的洗涤日用品牌，╮(╯▽╰)╭

# 总说
## 网页信标
img元素有一个src属性，当脚本设置img元素的src属性，且把信息作为图片的url的查询字符串部分，即能把经过编码的信息椽笔给web服务器，web服务器实际上必须返回一个图片作为结果。
事实上，使用一个空的js脚本也可完成此操作
一个百度统计的js脚本如下
```
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?d2539dae35b4dcf0e7814c110ecefa9f";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
```
分析，一个采用es5编写的一个闭包，动态加载一个script标签，向https://hm.baidu.com/hm.js?d2539dae35b4dcf0e7814c110ece发送一个get请求，并且查询的字符串为？后面的参数，服务器只需要统计？后面的get请求数目，即可完成一次次的统计任务。用户的页面停留，直接计算两次加载的时间差即可。数据库完成统计即可。一个最简单的页面统计完成。

## iframe
一个淘汰的标签。
下面是旧的ajax方式
使用iframe完成一次ajax，脚本先把要发送给web服务器的信息编码到url中，服务器在动态的创建一个html文档，将其内容返回给web，在iframe中显示，这种方式受道同源的限制。
上方的方式以及放弃。
## script
通过script元素的src属性设置url发起http get请求，即一种基于script的ajax传输，服务器使用json编码，执行脚本的时候，将其转码，这种的ajax同时也称为jsonp
即这种的跨域可以不受到同源的限制
## ajax中的x
ajax中的x为xml为一种可选的通信方式，也可以使用JSON完成通信。
## 其他
一些更多的通信协议，包括rpc（远程过程调用）允许运行于一台计算机的程序调用另一台计算机程序的子程序。如果面向对象编程，则远程过程调用为远程调用，远程方法调用。
## 发布/订阅事件系统
一种设计模式，有两种，一种是观察者模式，一种是发布订阅模式，
即，消息推送使用的是发布/订阅事件系统
### 观察者模式
意图：定义对象间的一对多的依赖关系，当一个对象状态发生改变时，所有依赖它的对象都得到通知，并进行更新
解决：一个对象状态给其他对象通知的问题，
举例应用：有个天气中心的目标A，专门监听天气的变化，而有个显示天气的观察者B，B把自己注册到A里，当A触发天气变化的时候，调度B更新方法，并带上自己的上下文。
![此处输入图片的描述][1]
### 发布/订阅模式
订阅者把自己想注册的事件注册到调度中心，当该事件触发时，发布者发布事件到调度中心，由调度中心统一调度订阅者注册到调度中心的处理代码。
举例：有个界面实时显示天气，它就订阅天气事件（注册到调度中心），当天气变化时定时获取数据，作为发布者到调度中心，调度中心调度订阅者的天气处理程序。
![此处输入图片的描述][2]
### 总结，区别
一个为点对点，一个为中间有一个过渡的，仅此而已。
> ps 有一本书js的设计模式，推荐看看 http://shop.oreilly.com/product/0636920025832/ReviewSubmit.do?sortby=publicationDate?pageId=0636920025832.IP  以及 https://addyosmani.com/resources/essentialjsdesignpatterns/book/
购买 https://www.amazon.com/_/dp/1449331815?tag=oreilly20-20
很想知道有木有中文版的。吐槽 28美元，合计120多元，书怎么那么贵呢。好贵，建议注册一下

# XMLHttpRequest
浏览器在CMLHttpRequest类上定义了其HTTP 的API 这个类的每个实例都表示一个独立请求/响应对。并且这个对象属性和方法允许指定请求细节和提取响应数据。
> 同java类似，使用这个api的第一件事实例化XMLHttpRequest对象

ps：能重用已存在的XMLHttpRequest 但是之前的对象将会被挂起

## HTTP请求的4个部分
1. http请求方法或者动作
2. 正在请求的URL
3. 一个可选的请求头集合，其中可能包含身份验证信息
4. 一个可选的请求主题

## HTTP返回的响应
1. 一个数字和文字组合成的状态码，如404（表示不存在）
2. 一个响应头集合
3. 响应主体

## 为什么本地不能直接使用ajax
在本地写js的时候，必须搭建一个服务器其AJAX才能工作
原因：因为文件的协议为file而本地的请求的协议为http，由于同源策略的影响，导致无法使用http协议的文件，故本地无法直接使用ajax
> 解决方法，chrome的浏览器访问https://chrome.google.com/webstore/detail/web-server-for-chrome/ofhbbkphhbklhfoeikjpcbhemlocgigb 安装chrome官方提供的本地测试服务器，用于在本地搭建服务器。
> 或者，编写Node.js 使用Express框架，加载Static 模块，完成本地的静态服务器搭建。

## 指定请求
指定请求使用的是request.open()，此方法将会初始化一个请求从js代码中调用。
第一个参数指定HTTP方法或动作，字符串不区分大小写，通常用大写字母匹配HTTP协议，GET用于常规请求，适用于当URL完全指定请求资源。当请求对服务器没有任何副作用以及当服务器的响应可缓存的时候，使用GET。对于POST来说，常常用于HTML表单，它在请求主体中包含额外数据，即表单数据，且这些数据常常储存到服务器的数据库中。此请求不会被缓存。
同样的，还允许其他的一些请求，例如DELETE，HEAD，OPTIONS，PUT等请求。
第二个参数为URL，为请求的主体，相对于文档的URL，这个文档包含调用open()的脚本，这个不能跨域，请求必须为同域的

### 设置请求头
```
request.setRequestHeader('Content-type', 'text/plain');
```
下面将会设置请求头，上方设置请求头为Content-type的内容为text/plain
> 有些请求头由于浏览器的安全问题，被禁止请求，所以有些不能请求。

如果请求一个受到密码保护的url，此时不需要设置Authorization头，只需要直接在open的第三四个参数，传入即可。

### 发送请求
由于get请求不包括主体，则直接send方法即可完成一个包的发送，
#### 由于跨域限制导致不能读取
在http://1.197.156.53/编写js如下
```
// 编写请求头GET并完成发送
var request = new XMLHttpRequest();	// 设置请求的类
request.open('GET', 'https://www.baidu.com/');	// 设置请求的链接和方式
request.setRequestHeader('Content-Type', 'text/plain');	// 设置请求头
request.send(null);	// 发送包
```
![此处输入图片的描述][3]
跨域请求被拦截。
由于不是同源，同源被拦截

#### 是同源的
```
// 编写请求头GET并完成发送
var request = new XMLHttpRequest();	// 设置请求的类
request.open('GET', './index.js');	// 设置请求的链接和方式
request.setRequestHeader('Content-Type', 'text/plain');	// 设置请求头
request.send(null);	// 发送包
```
完成一次发包操作

#### 顺序问题
HTTP请求的各个部分有指定的顺序，请求方法和URL会首先到达，然后接着请求头，最后请求主体。最后调用send()方法，完成发送。
顺序问题:必须先调用open后调用send()才方可。

#### 一个栗子，通过post方法发送纯文本给服务器
```
function postMessage(msg) {
	var request = new XMLHttpRequest();	// 新请求
	request.open('post', '/log.php');	// 用POST向服务器端发送脚本
	// 用请求主体发送纯文本消息
	request.setRequestHeader('Content-Type', 'text.plain;charset=utf-8');	// 请求主体将是纯文本

	request.send(msg);
	// 请求完成，我们将忽略任何响应和任何错误
}
```
即上方定义了一个post请求，完成其发送，等待其服务器响应

## 取得响应
send()发送以后将会等待服务器响应，此时将不会阻塞。
在HTTP发送完成请求以后，下一步将会取得响应。
下面编写函数获取HTTP响应的onreadystatechange
```
// 发出一个HTTP GET请求获取指定的URL的内容
// 当响应成功到达，验证它是否是纯文本
// 如果是，将会把它传递给指定的回调函数
function getText(url, callback) {
	var request = new XMLHttpRequest();	// 创建一个新请求
	request.open('GET', url);	// 创建一个指定待获取的url
	request.onreadystatechange = () => {	// 当GRT请求完成以后，触发该事件，产生回调函数
		// 如果请求完成，则它是成功的
		if (request.readyState === 4 && request.status === 200){	// 如果下载操作完成，即为4，并且http状态码为200
			var type = request.getResponnseHeader('Content-Type');	// 获取HTTP头部信息
			if (type.match(/^text/))	//正则匹配，确定响应为文本
				callback(request.responseText);	// 回调函数,将返回的DOM树，传递给回调函数
		}
	};

	request.send(null);	// 发送
}
```
> 注意，该方式为异步的，send方法不会阻塞其他操作

### 同步响应
由于其下载的问题，一般异步处理HTTP响应，但是同步也可以，不过由于客户端js为单线程的，当send()方法阻塞以后，将会导致浏览器的ui被冻结，如果连接的服务器过慢，将会导致用户的操作出现问题。

> 方法直接open使用第三个参数为false

### 响应解码
当服务器响应的为XML文档的时候，其返回的值为document对象，能使用操作节点的方式，对其进行操作
当服务器发送对象或者数组的结构化数据，如JSON，
> 使用JSON.parse 对结构化数据进行解析

下方书写一个函数，进行结构化数据的解析
```
// 发起HTTP GET响应，获得指定的URL内容
// 当响应到达时，把他们解析后的XML Document对象，解析后的JSON对象
// 或者字符串形式传递给回调函数
function get(url, callback){
	var request = new XMLHttpRequest();
	request.open('GET', url);	// 指定url
	request.onreadystatechange = () => {	// 监听器
		// 如果请求完成且成功
		if (request.readyState === 4 && request.status === 200) {
			// 获得响应请求
			var type = request.getResponseHeader('Content-Type');
			// 检查类型
			// 当为xml的时候
			if (type.indexOf('xml') !== -1 && request.responseXML)	// 确认是否为xml
				calback(request.responseXML);	// 回调函数
			else if (type === "application/json")	// 如果头部的信息为JSON
				callback(JSON.parse(request.responseText));	// 将结果JSON格式解析
			else 
				callback(request.responseText);	// 如果是字符串响应
		}
	};
	request.send(null);	// 立即发送请求
}
```
对两种数据解析，一种为JSON格式，一种为XML格式
> ps 不建议使用eval

> ps 由于跨域的问题，只能读取同源的数据，通过script脚本操纵HTTP脚本并实现加载并执行脚本

> script 元素能发起跨域的HTTP请求

能使用request.overrideMimeType能够实现对MIME类型的更改




  [1]: https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/14/11.png
  [2]: https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/14/12.png
  [3]: https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/14/13.png