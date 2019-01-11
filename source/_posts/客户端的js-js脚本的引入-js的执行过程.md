title: 客户端的js js脚本的引入 js的解析过程
author: Ming ming
tags:
  - js
  - 客户端js
  - js脚本引入
  - js解析过程
categories:
  - 前端
  - js
  - 客户端js
  - ''
date: 2018-08-02 20:39:00
---
web浏览器中的JavaScript
web浏览器中的js通常称为客户端的JavaScript
# 客户端 JavaScript
window对象是所有客户端JavaScript特性和api的主要接入点。
即，表示web浏览器一个窗口或窗体。使用标识符window来完成引用。
## 属性
window对象定义了一些属性，用来指定当前窗口的一些信息。通过该属性的引用，可以获取当前窗口的信息
```
// web API 接口 获取当前页面的信息，返回一个页面信息的对象
window.location
// 所有的必须小写，为只读属性。
```
```
// 设置localtion属性，完成跳转到一个新的页面，即使是原来的链接也会完成跳转
window.location = "https://www.google.com.hk";
```
注意，该属性为只读属性，不可进行修改，能进行赋值操作，并不意味着能进行修改。进行赋值以后会完成页面的跳转，而让其达到被修改的目的。
## 方法
window还定义了一些方法，alert()弹出对话框，以及setTimeout()注册一个函数，在给定的一段时间以后触发回调
```
> setTimeout(() => {alert("hello word!");}, 2000);
2
```
返回值为一个定时器的编号，该定时器和window.setInterval(重复调用一个函数，或执行一段代码)共用一个编码池。
该代码，并没有显式的使用window属性。但是依然隐式的使用了window属性。因为window为全局对象，即window对象处于作用域链的顶部，其属性以及方法为全局变量和全局函数。在没有直接说明的时候，自动从作用域链往上寻找，直到window顶部。window对象有一个引用自身的属性，即window，如果要引用其窗口本身，可以用window这个属性。
即上方代码和下方代码等价
```
> window.setTimeout(() => {alert("hello word!");}, 2000);
2
```
## 一个属性document
该属性引用Document对象，为window对象的一个属性。该属性有一些方法。该方法同时也为document属性的一些方法（因为是引用关系）
例如
```
// 寻找 id = "timestamp" 的元素
> var timestamp = document.getElementById("timestamp");
undefined
> timestamp;
<div id="timestamp">
// 获取脚本的内容
> timestamp.firstChild
#text "2222222"
// 插入当前时间
> timestamp.appendChild(document.createTextNode(new Date().toString()))
```
# html嵌入js
html嵌入js有四种方法
1. 内联，放置在
```
<script>
```
和
```
</script>
```
标签对之间
2. 放置在
```
<script>
```
标签的src属性指定的外部文件中
3. 放置在html事件处理程序中，该事件处理程序由onclick或onmouseover这样的html属性值指定
4. 放在一个url里，这个url使用javascript:协议
后两个用的很少
因为需要html和js分离，依据mvc进行分离，使得html变的结构化，易于阅读

## script元素
下面是一个数字时钟使用onload事件处理程序
> Element.innerHTML 属性设置或获取HTML语法表示的元素的后代。

```
<!DOCTYPE html>
<html>
<head>
	<title>数字时钟</title>
	<script>
		// 定义一个函数显示当前时间
		function displayTime() {
			var elt = document.getElementById('clock');	// 通过id寻找到元素
			var now = new Date();	// 得到当前时间
			elt.innerHTML = now.toLocaleTimeString();	// 让elt来显示
			setTimeout(displayTime, 1000);	// 让其1秒后执行
		}
		window.onload = displayTime; // 当页面或图像加载完成以后显示时间
	</script>
	<style>
	#clock {
		font:bold 24pt sans;	/*设置字体*/
		background:#ddf;	/*设置蓝灰色的背景*/
		padding:10px;	/*周围有一圈空白*/
		border:solid black 2px;	/*定义纯黑色边框*/
		border-radius:10px;	/*定义圆角*/
	}
	</style>
</head>
<body>
	<h1>Digital Clock</h1>
	<div id="clock"></div>
</body>
</html>
```
## 外部文件中脚本
使用
```
<script src="./script/util.js"></script>
```
的src属性进行引用
可以在标签内部加上版权以及配置
```
<script src="core.js">
    config = {..}
</script>
```
定义了一个配置项，由core.js读取。将页面的参数传入库的一种手法。在
```
<script></script>
```
之间的代码是纯文本。在core.js执行的时候读取这段文本，然后动态执行一次。浏览器不会执行之间的代码
## html中的事件处理程序
当脚本所在的html文件被载入的时候。脚本里的js会执行一次。为了可交互，js会定义事件处理程序即web浏览器先注册函数，并在之后调用其作为事件的响应。其中事件处理程序的属性可以包含任意条js语句。相互之间用逗号分隔。该语句会成为一个函数体，然后这个函数体成为对应事件处理程序属性的值。
## url中的js
应用用途 书签
通过协议类型指定url内容为任意字符串，该字符串是会被js解释器运行的js代码，其会被当成单独的一行代码实现。即语句之间必须使用分号作为分割。
即，书签的实现。如果书签是javascript:url，那么将会保存一小段脚本。该脚本是一个小型程序，即可以在浏览器菜单或工具栏里启动。该代码执行会像页面上的脚本一样，查询和设置文档的内容，呈现和行为（不能有返回值，会重新促使浏览器渲染）即通过书签，操作文档，将文档替换成为新的内容
## js程序的执行
这些代码都会功用同一个全局window对象。即都能共享全局函数和全局变量的集合。即一个页面中js都会在执行后对所有的全局变量和函数都可见。
如果使用的窗体，
```
<iframe>
```
即这两个页面共享的不是同一个window，会被当做独立于页面的js程序。
### js程序执行的阶段
#### 一阶段
载入文档内容，执行所有脚本，一般是从上到下的
#### 二阶段
文档载入完毕，所有脚本执行完毕。js进入第二阶段，该阶段为异步，由事件驱动。web会调用事件处理程序，对事件进行处理。一般事件会是用户输入，键盘输入，网络活动，运行时间等等。
事件驱动的第一个事件，即第一个被执行的事件为load事件。
### js的同步，异步和延迟脚本
因为载入文档和执行脚本是一并执行的，所以在第一次执行脚本的时候，会没有api来操作文档，和遍历内容。在文档载入的时候，影响文档内容的方法为快速生成内容。
> document.write() 将字符串写入document.write()打开的文档流

一个例子
```
<h1>计算阶乘</h1>
<script>
	function factorial(n) {	// 一个计算阶乘的函数，用递归实现
		if (n <= 1)
			return n;
		else
			return n * factorial(n-1);	
	}

	document.write("<table border=1>");
	document.write("<tr><th>n</th><th>n!</th></tr>");
	for(var i = 1; i <= 10; i++) {
		document.write("<tr><td>" + i + "</td><td>" + factorial(i) + "</td></tr>");
	}
	document.write("</table>");
	document.write("生成时间为" + new Date());
</script>
```
这样在加载的时候完成了页面文档的修改，并输出。为1996年的技术
╮(╯▽╰)╭
当脚本把文件传递给document.write()的时候，该文本会被添加到文档的输入流中，html解析器会在当前位置创建一个文本节点，将文本插入这个文本节点后面。当html的解析器遇到script元素的时候，默认先执行脚本，再恢复文档的解析和渲染。但是如果是src的话，将会导致，脚本未下载和执行之前，都不会出现在dom树中。都会等待js的脚本执行。称之为阻塞页面ui的渲染。
脚本执行默认情况下是同步和阻塞的。
>　script 有两个属性，h5中，为async 以及 defer 该两个属性可以支持异步执行js脚本。因此这样浏览器将会在下载脚本的时候继续解析和渲染文档。可以达到延迟脚本的执行，直到文档载入和解析完成，才方可操作。不会出现js阻塞页面ui的渲染。异步的时候执行是无序。

### 事件驱动的js
js还能通过注册事件程序函数写程序。之后在发生该事件的时候异步调用这些函数。
程序会响应一个事件，然后调用一个函数，该函数称为事件处理程序，事件监听器，或者回调，将该函数注册。
>　一个约定，事件处理程序一般是on开头的

举例
```
window.onload = function() {};
document.getElementById('button1').onclick = function(){};
```
在发生onload事件的时候，回调第一个函数，在发生点击button1的时候回调第二个函数。
#### 冒泡
如果事件的目标是文档元素，如果该文档元素没有相应的处理事件，将会往上传递文档树，知道遇到注册的事件。这个过程称之为冒泡。

#### addeventListener
```
// 注册函数f， 当文档载入完成时执行这个函数f
// 如果文档载入完成，将会用异步的方式执行
function onload(f) {
	if (onload.loaded)	// 如果文档以及载入完成
		window.setTimeout(f, 0);	// 设置一个定时器，放入js执行的队列中，等待执行
	else if (window.addEventListener)	// 将事件进行注册
		window.addEventListener("load", f, false) // 注册事件 load, 当加载完成以后执行函数f，
}
// 设置标志，指示文档是否载入完成
onload.loaded = false; // 表明未载入完成，
// 注册函数，当文档载入完成时载入标志
onload(() => {onload.loaded = true;});

// 大概解释一下，首先定义了一个函数，设置了一个加载的标志，在加载的过程中，设置loaded的值为false，当加载完成以后，执行onload函数，将其内部定义的函数传入onload中，和load事件进行绑定。等待文档载入完成，触发一个匿名函数，将onload.loaded的值改为true，此时再次传入的函数f将会返回js的执行队列中，等待执行。
```
将一个监听器和回调函数绑定，当监听器被触发的时候，回调函数将会被触发。

### 客户端js线程模型
js的客户端为单线程模型。
h5中有一种并发的控制方式，为web worker 为一个后台线程，允许线程里的代码访问文档的内容。不能和主线程或者其他worker共享状态，只可进行异步事件进行通信。

### 客户端js时间线
1. web浏览器先创建document对象，并且开始解析web页面，（即根节点），解析html元素和其文本内容都会添加到其后方的节点中
2. html遇到script元素的时候，先执行内部脚本，等待内部脚本执行完毕后，在继续解析html节点，此时节点解析会暂停。可以使用document.write()实现将文本插入流中。解析器恢复解析的时候，该文本会正式的成为文档的一部分，但是页面的源码中并不存在该内容。该操作此时是同步的，可以达到遍历和操作文档树的目的。因为在执行的时候，其上方的文档树就已经存在。
3. 遇到async属性的时候会边下载，边进行解析html。异步的时候禁止使用document.write，因为此时脚本无法插入文档流中。异步的时候，解析是随意的。也不清楚什么时候脚本会解析。
4. 文档解析完成。document.readyState将会变成interactive，之前一直为loading状态。此时表明解析完成
5. 所有有defer属性的脚本，会在此时执行，此时能访问完成的文档树，但是禁止使用document.write()因为此时文档树已经固定
6. 浏览器进入异步事件驱动阶段。此时可能还没有异步脚本执行完成。
7. 此时文档全部解析完成，但浏览器可能在等待图片的加载，等所有的异步脚本全部完成载入和异步执行的时候，将会触发load事件，表明全部执行完成，readState将会改为complete
8. 此刻调用异步事件，响应用户输入事件，网络事件，计时器事件。

### 兼容
#### ie条件注释
尽管现在兼容不是那么严重了，ie也淘汰了，edge上台了。但还是说一下吧
```
<!-- [if IE]>
<script src="excanvas">
</script>
<![endif]-->
```
ie支持条件注释，上方是使用条件注释的，在ie下,将会执行上方的js脚本
通过
```
@_jscript
```
可以判断是不是ie，因为该变量在ie中圆圆为true
写法如下,用于ie的
使用条件注释来写
```
/*@cc_on
    @if (@_jscript)
        // 书写兼容的ie代码，在ie下会被执行，
        alert("in ie")  // 发出警告
    @end
```
再ie下也会进行执行。
总结 一下
```
/*@*cc_on
    @if(@_jscript)
        // 这里的代码尽管被注释，也会执行在ie中
        // ie会执行这段代码，其他浏览器不会执行
        alert('ie')
    @else*/
        // 这段代码并没有在js注释中，但仍然在ie条件注释中。
        // 除了ie之外都会执行
        alert("not ie")
/*@end
@*/
```
#### 处理兼容的类和库
exanvas.js
#### 功能测试
使用if进行测试，是否实现了
#### 怪异模式和标准模式
使用标准模式就行了
记的加上h5的声明
#### 浏览器测试
可以根据头部信息，web服务器返回响应的js代码
