title: cookie
author: Ming ming
tags: []
categories:
  - 前端
  - js
  - 客户端js
date: 2018-09-28 00:33:00
---
cookie
cookie是指web浏览器储存的少量数据，同时也是与具体页面有关的。
cookie会自动在web服务器和web浏览器中传输。
> cookie 是用来保存状态的。即用户登录，一个网站如何判断用户登录的时候，会直接通过从客户端接收到的cookie来获取的。

# cookie 属性，有效期和作用域
除了名(name)和值(value),cokie持续有效时间很短，只能持续在web浏览器的会话期间。一旦用户关闭浏览器，用户保存的数据就全部丢失。cookie需要设置有效期。即设置max-age属性，通过设置其属性完成对cookie有效期的设置。
设置了有效期以后，cookie数据会储存在一个文件中，直到过了指定的有效期才会删除文件。
cookie拥有作用域，其作用域是通过文档源和文档路径设置的。默认情况下，cookie和创建其的web页面有关。并对同目录和其子目录的其他web页面可见。对父级目录不可见。
一个栗子，当用户在页面输入了其电子邮件地址，需要保存下来，这个时候希望整个网站都使用其电子邮件地址，这个时候，通过设置cookie中的path属性即可实现作用域为全部。
如果将路径设置为/ 即让cookie和localStorage拥有同样的作用域。同时当其请求该站点上的任何一个web页面的时候，浏览器都必须将cookie的名字和值传递给服务器。
> 这里需要注意一点的是，如果一个web页面，想要读取其他页面的cookie，只需要随便加载一个页面，并使用iframe标签，即可读取对应文档的cookie，此操作受到同源的限制。

如果需要子域名之间能共享cookie此时需要设置cookie的domain 如果没有为一个cookie设置域属性，那么domain属性的默认值为当前web服务器的主机名。
cookie的另外一个属性为secure 其为布尔值，用来表明通过哪种网络传递。cookie默认是不安全的传递，即可以通过http传递，一旦设置为true的时候，必须通过https进行传递。
## 总结
名称 | 含义
------|-----
Name | 储存的名称
Value | 值
Domain | 用于域的共享，实现子域的互通
Path | 设置cookie的路径
secure | 表明cookie是否以不安全的方式传递

# 保存cookie
cookie为键值对。
即需要按照以下的字符串进行设置
```
name = value
```
如下所示
```
document.cookie = "version=" + encodeURIComponent(document.lastModified);
```
由于cookie中储存的不允许包含分号，逗号，空白符，所以在储存前使用encodeURIComponent()核心函数进行编码，解码的时候使用encodeURIComponent()函数解码
> 和POST中的请求体类似。

如果设置天数，需要按照以下的字符串进行设置
```
name = value; max-age = seconds
```
下面的函数是设置一个cookie的值
```
// 以名/值的形式储存cookie
// 同时采用JavaScript核心函数encodeURIComponent()函数进行对值的编码
// daysToLive的值为天
function setcookie(name, value, daysToLive) {
	var  cookie = name + "=" + encodeURIComponent(value);
	// 如果传入的天数为数字格式的
	if (typeof daysToLive === "number") 
		cookie +=  "; max-age=" + (daysToLive*60*60*24);	// 由于上一个已经是一条，需要使用； 来作为结束
	document.cookie = cookie;	// 将字符串传入cookie
}
```
同样的如果想要 继续设置cookie的值，还需要继续在后面加上值
```
; path = path
; omainn = domain
; secure
```
如果要删除cookie，需要设置同样名字的即可完成。

# 读取cookie
因为读取的是一个字符串，所以需要使用split()方法将cookie的值中的名值对进行分离。使用JSON.parse()将其转化为JSON对象
```
// 将docuemnt.cookie 的值以名值对组成的一个对象返回
// 假设储存cookie的值的时候是采用encodeURIComponent()函数进行编码的
function getcookie() {
	var cookie = {};	// 初始化要保存的对象
	var all = document.cookie;	// 在一个字符串中获取cookie的值
	if (all === "") 
		return cookie;	// 如果返回的是一个空对象
	var list = all.split(";");	// 进行分离
	for(var i = 0; i < list.length; i++) {
		var cookie = list[i];	
		var p = cookie.indexOf("=");	// 查询第一个=
		var name = cookie.substring(0, p);	// 获取cookie的名字
		var value = cookie.substring(p+1);	// 获取cookie对应的值
		value = decodeURIComponent(value);	// 对其值进行解码
		cookie[name] = value;	// 将名/值对储存到对象中
	}
	return cookie;	// 返回cookie
}
```
# cookie的局限性
对cookie数量，大小有限制。