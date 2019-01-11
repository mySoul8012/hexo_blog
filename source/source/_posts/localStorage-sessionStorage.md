title: localStorage sessionStorage
author: Ming ming
tags: []
categories:
  - 前端
  - js
  - 客户端js
date: 2018-09-26 23:48:00
---
# localStorage 和 sessionStorage
Window.localStorage 当页面会话结束的时候，数据将会被清除。
> 之前一刷新页面，直接被清除，后来发现是浏览器插件引入的js脚本，导致出现问题，在思考，如何验证网页是否被插入js脚本，即，类似于掘金社区的，每次访问都会提示，被插入脚本。此有一个专业术语，叫SRI

## SRI 
原理，使用哈希值验证前端资源的完整性。
大文档 https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity

### CSP
即内容安全政策，要求强制浏览器启用，白名单制度，要求浏览器那些可以访问，那些不能访问。

## localStorage
此没有过期时间，只有当第三方，或者用户手动清理的时候，才会清空，其余都会一直在浏览器里保存。
演示
```
var number = Number(localStorage.number);
if (number) {
	++number;
}else {
	number = 1;
}
localStorage.number = number;
document.write(number);
```
js文件如上，每次刷新页面重新加载的时候，都会从浏览器中读取localStorage.number的内容。然后进行自增。
场景 用于计数操作
## seessionStorage
此为一个会话的储存，储存在会话当中，关闭浏览器标签以后，将会被清除，
> 这两个都受到同源的影响，但是sessionStorage最大的不同在于同一个网站，渲染同一个页面，即使是两个标签，其sessionStorage不可共享，但是iframe可以共享，localStorage受到同源的影响，可以共享。

# 存储api
一些浏览器厂商定义的api
其中有两个方法，为setItem()以及getItem()这两个方法可以设置值，可以获取值。
一个demo
```

localStorage.setItem("x", 1);	// 设置值
localStorage.getItem("x");	// 读取值

// 枚举所有的名值对
for(var i = 0; i < localStorage.length; i++) {
	var name = localStorage.key(i);	// 获取第i对名字
	var value = localStorage.getItem(name);	// 获取该对的值
	console.log(name + "," + value);	// 输出值
};

localStorage.removeItem("x");	// 删除x项
localStorage.clear();	// 全部删除
```

ps： getItem获取的仅仅是储存的副本

# 储存事件
如果储存在localStorage 以及 sessionStorage的数据发生更改，浏览器会在所有数据可见的页面，触发事件
> 在对数据进行改变的窗口对象上不会触发该事件

eg；如果两个页面，其中一个页面储存了localStorge，那么另外一个页面也会触发储存的事件。
> 回顾，注册事件使用的是addEventListener()方法

事件有key newValue storageArea url
此为四个事件
## 事件
key事件为设置或者移除项的名字或者键名。
newValue 保存新项目的值
oldValue 改变或者删除之前的值
url 触发编号的url
stroageArea 为windows对象上的sessionStroage的值

事件是采用广播机制的。
ps 如果一个用户要求网站停止动画，而这个配置是储存在localStroage中的，那么同源的将会全部停止动画
ps 一个文本编辑，如果用户选择一个工具的时候，可以通过其值，完成通知另外窗口的选择了该工具，用于窗口间的值的传递