title: jQuery (二)
author: Ming ming
tags:
  - jQuery
  - jQueryUI
categories:
  - 前端
  - js
  - 客户端js
date: 2018-08-24 05:33:00
---
# 使用jQuery处理事件
## 事件处理 
一个栗子，单击p时背景变成灰色
> 由于es6的箭头函数不支持this的绑定，所以无法使用箭头函数，只能使用匿名函数

html
```
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
</head>
<body>
	<p>hello world</p>
</body>
</html>
<script src="./style.js"></script>
```
js
```
// 单击任意p时，使其背景变成灰色
$('p').click(function () { $(this).css('background-color', 'gray'); });
```
效果
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/21/20180821_175532.gif)


或者使用第二个参数，添加相关的属性，完成事件的相关触发
```
// 单击任意p时，使其背景变成灰色
$('<img>', {
	src: image_url,
	alt: image_description,
	className: "translucent_image",
	click: function() {
		$(this).css('opacity', "50%");
	}
})
```
效果同理。
## 事件处理程序的高级注册
使用bind()为添加事件
```
$('p').bind('click', f);
```
将p元素的click事件和函数f进行绑定，需要使用闭包

还可以使用三个值，第一值为事件，第二个值为Event对象的data属性，在调用最后一个处理函数的时候，会将第二个值作为对象的data属性,这样即可避免使用闭包操作
> ps jquery 中所有的处理程序都有一个函数 例如 hover() 

mouseenter 绑定鼠标在进入的时候
mouseleave 绑定鼠标在离开的时候

```
$('p').bind('mouseenter mouseleave', f);
```

还可以使用英文句号，作为命名空间，这样方便对多个回调函数的管理
下方的是将函数f注册在命名空间myMond
```
$('p').bind('mouseover.myMod', f);
```
下方的是将函数f注册到命名空间yourMod和mouseout中
```
$('p').bind('mouseover.myMod.yourMod', f);
```
或者使用对象
```
$('p').bind({ mouseenter:f, mouseleave:g });
```

## 注销事件处理程序
```
$('*').unbind();	// 从所有元素中移除所有的jquery事件处理程序
```
```
$('a').unbind('mouseover mouseout');    // 移除两个属性
```
```
// 取消绑定在myMod命名空间下的所有mouseover 和mouseout处理程序
$('a').unbind('mouse.myMod mouseout.myMod');
// 取消绑定在myMod命名空间下的所有事件处理程序
$('a').unbind('.myMod');
// 取消同时绑定在ns1和ns2命名空间下的单击处理程序
$('a').unbind('click.ns1.ns2')
```
使用命名空间达到模块化的目的

```
// 使用函数名，达到注销事件处理程序
$('#mybutton').unbind('click', myClickHandler);
// 或者
$('a').unbind(
		{
			mouseover: mouseoverHandler,
			mouseout: mouseoutHandler
		}
	)
```
## 触发事件
> jquery的事件处理为同步的，没有异步。

```
$('#my_form').submit();	// 模拟用户点击按钮进行提交
```
或者使用trigger
```
$('button').trigger('click.ns1');	// 触发命名空间.ns1下的绑定函数
$('button').trigger('click!');	// 触发没有命名空间的单击处理程序
```
或者如下
```
// 单击一将会触发二上的事件
$('#button1').click((e) => {$('#button2').trigger('button2')});
// 触发事件时，将会添加额外的属性给事件对象，如果事件以前被监听，将会被直接触发
$('#button1').trigger({ type:'click', synthetic:true });
```

```
$('#button1').trigger('click', true);   // 传入的第二个参数将会成为触发事件的参数，进行传入
$('#button1').trigger('clcik', [x, y, z]);  // 传入三个额外的参数
```

```
$('*'); // 选择所有元素进行触发
// 或者使用工具函数
jQuery.event.trigger(); // 使用工具函数完成全部的选择 https://api.jquery.com/category/events/event-object/
```
## 自定义事件
一个栗子，实现发布订阅模型，先全体元素广播一个事件,在单击一个按钮的时候
```
$('#logoff').click(() => {
    $.event.trigger('logoff');  // 实现一个先全体元素广播一个事件
})
```
如果元素要接收事件，需要绑定一个监听器即可，至此完成发布订阅模式。

## 实时事件
实时事件为，如果先前将所有a元素绑定了一个事件，接着在创建一个新的a的节点，如果此时触发事件，则新创建的a元素不会被触发事件，因为绑定的不是实时的事件。
由于更新，live，bind，delegate，die，undelegate 全部废弃
> 注意，这一部分全部废弃

# 动画效果
动画效果实质上是通过定时的修改css属性，达到动画的效果
一个栗子
https://api.jquery.com/fadeIn/ 
使用淡入效果
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/23/1.gif)
```
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<script src="/public/js/jquery.js"></script>
	<link rel="stylesheet" href="/public/css/style.css">
</head>
<body>
	<p>
  Let it be known that the party of the first part
  and the party of the second part are henceforth
  and hereto directed to assess the allegations
  for factual correctness... (<a href="#">click!</a>)
  <div><span>CENSORED!</span></div>
</p>
```
```
$('a').click(function (){
	$('div').fadeIn(3000, () => {
		$('span').fadeIn(100);
	});
	return false    // 说明动画是否放进队列，如果未false 表明动画将不会放入队列，默认为false，还可以设置名字，进行队列分类。
})
```
```
p {
	position: relative;
	width:400px;
	height:90px;
}
div {
	position: absolute;
	width:400px;
	height:65px;
	font-size:36px;
	text-align:center;
	color:yellow;
	background:red;
	padding-top:25px;
	top:0;
	left:0;
	display:none;
}
span {
	display:none;
}
```
当运行的时候会，自动将display设置为可见。
注意，jquery动画效果为异步的，调用fadeIn()方法的时候，会立即返回，动画则在后台执行，
如下
```
$('a').click(() => {
	$('div').fadeIn(3000, () => {
		$('span').fadeIn(100);
	});
	return false;
})
```
当发生click事件的时候，会先回调click内的事件，发生动画，在等待3000秒的时候，继续回调下一个函数，由于是异步的，先返回false，再执行动画，false的意思为通知click事件不能进入队列中，进行等待。
> 动画异步好坑，动画实际上是通过定时器来完成的，由于定时器是一段段的执行，所以动画为异步操作，先执行返回，动画等待某个时刻进行执行。返回的结果，并不一定执行完毕。返回的结果，并不是执行完毕。

如果想要执行多段动画，无需使用回调，因为动画为队列机制，直接采用链式即可。
## 禁用动画
如果不需要动画，直接使用
```
jQuery.fx.off
```
直接设置其值为false即可实现动画的禁用。
## 简单动画
### fadeIn(),fadeOut(), fadeTo().
其中fadeIn需要之前该对象的display为noen或者visibility，通过动画显示出，上方有栗子，不在演示。
fadeOut()，同样相反，也有异步，也有队列。
> ps 这两个效果类似于visibility 虽然消失，但是依旧对流具有影响

### show(), hide(), toggle()
hide类似于使用display，将其值设置为none类似。
```
$( "button" ).click(function() {
  $( "p" ).hide( "slow" );
});
```
上方，设置button，触发事件，回调p，设置动画，
解释一下最后的参数，如果没有参数，将会直接设置display的值为none，如果有任意一个参数，将会设置高度和不透明度，将其变为0，并且display也将会变为none，确保不会影响页面的布局。
> 可以设置缓动函数为字符串

toggle，同样如果有字符串，也将会实现如此。
```
$( "button" ).click(function() {
  $( "p" ).toggle( "" );
});
```
上方代码，实现了切换p标签，两种状态的切换。

### slideDown(), slideUp(), slideToggle()
slideUp() 是将高度动态变化到0，然后社会display属性为none，为向下
slideDown()正好相反。为向上
slideToggle() 使用向上滑动和向下滑动，切换元素的可见性。
### 调用
```
$( "button" ).click(function() {
  $( "p" ).fadeOut().show(30000).slideToggle();
});
```
将会先隐藏，在显示出，接着进行切换。
> ps 由于动画为队列，可以这样使用

### 自定义动画
使用animate()
> ps css3中，有类似的动画，是通过定义关键帧达到的。

```
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>toggle demo</title>
  <style>
  p {
    background: #dad;
    font-weight: bold;
    font-size: 16px;
  }
  </style>
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
 
<button>Toggle 'em</button>
<p>Hiya</p>
<p>Such interesting text, eh?</p>
 
<script>
$( "button" ).click(function() {
  $( "p" ).animate({
      width: "90%"
    }, {
      queue: false,	// 将动画不放入效果队列中
      duration: 3000	// 持续时间为3000毫秒
    })
    .animate({ fontSize: "24px" }, 1500 )	// 继续发生以下动画
    .animate({ borderRightWidth: "15px" }, 1500 );
});
</script>
```
效果，
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/23/20180821_175532.gif)

#### 动画属性对象
animate()方法的第一个参数必须为对象，该对象必须为css的属性名（使用驼峰命名法）
动画只支持数值属性，不支持颜色，字体，或者display的枚举属性。
```
$('p').animate({
	marginLeft: "+=.5in",	// 增加段落缩进
	opacity: '-=.1'	// 同时减少不透明度
})
```
hide会保存当前属性的值，然后将值变化到0，show值，进行还原，

> 动画在使用hide的时候，会在完成的时候调用，如果动画使用show，将会在完成时，调用show



#### 动画选项对象
> 缓动函数，jquery中有默认的缓动函数，为正弦函数，即swing，还有一个线性的缓动函数为linear 所有的缓动函数都在jQuery.easing中，![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/23/1.png) 
上方的缓动函数，还可以自定义，即添加一个数组即可，如
```
jQuery.easing['squareroot'] = Math.sqrt; 
```

如果想要使用线性变化即
```
$('p').animate({
	'width': '+=100'
}, {
	duration: 500,
	easing: "linear"
})
```
或者使用传入参数的方式
```
$('img').animate({
	"width": "+=100"
}, 500, "linear");
```
或者为不同的css动画属性定义不同的缓动函数
```
// 用hide()方法，隐藏图片，图片大小用线性的动画
// 不透明度采用swing缓动函数
$('img').animate({
	width: "hide",
	height: "hide",
	opacity: "hide"
}, {
	spacialEasing: {
		width: "linear",
		height: "linear"
	}
})
// 或者
$('img').animate({
	width: ['hide', 'linear'],
	height: ['hide', 'linear'],
	opacity: 'hide'
})
```
#### 动画取消，延迟和队列
stop() 将会停止当前选中元素上的任何动画，top接受两个可选的参数，如果第一个为true将会清楚当前队列，否则队列将不会被清除，第二个为是否保留当前值，如果未true将会变化到终值，如果为false将会保持当前值，然后开始执行动画
```
// 当属性悬浮在图片上时，图片将会不透明
$('img').bind({
	mouseover: function () {
		$(this).stop().fadeTo(300, 1.0);
	},
	mouseout: function () {
		$(this).stop().fadeTo(300, 1.0);
	},
})
```
> 注 bind已不推荐使用

还有一个为delay() 这会直接添加一个时间延迟到动画队列中。
```
//快速淡出为半透明，等一等，然后向上滑动
$('img').fadeTo(100, 0.5).delay(200).slideUp();
```
每一个队列都和文档元素相关联，每一个元素的队列都与其他元素的队列彼此独立，即，使用queque()方法，给队列添加一个新函数
```
// 淡入的显示一个元素，稍等片刻，设置一些文字，然后变化边框,为对队列的操作，添加到队列的最后
$('#message').fadeIn().delay(200).queue(function(next) {
	$(this).text('hello world');	//显示一些文字
	next();	// 方便下一个继续调用
}).animate({
	borderWidth: "+=100px;"
});
```
clearQueue()方法将会清楚队列，给queue()方法，传入一个函数组成的数组，而不是单一函数时，将会传入函数数组来替换当前队列。
```
$(e).queue(f);  // 创建一个持有e的jquery对象，并调用queue方法
jQuery.queue(e, f); // 直接调用jQuery.queue工具函数,进行替换队列
```
jQuery中默认的队列名为fx，这是没有指定队列名时默认使用的队列。
# Ajax
Ajax实现了不需要刷新，即可动态的加载一部分页面，
## load
是滴，load如果传入的参数为字符串，而是函数，load为事件的处理程序的注册，而不是ajax方法。
如果传入的是url，则将会进行替换
> load为异步操作，不会发生阻塞，发送完成以后，将会直接执行下一步操作

!()[https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/23/2.gif]
```
$('p').load('./1.html')
```
当然也可以加载一部分
```
// 加载并显示天气报告的温度部分
$('temp').load('wheather_report.html #temperature')
```
> ps 同源

load还会接受可选参数，第一个可选参数表示的数据，可以追加到url后面，如果传入为对象，将会直接用&分隔的名值对请求发送。并且将会以post请求发送。
```
// 加载特定区号的天气预报
$('#tmp').load('us_weather_report.html', 'zipcode=02134');
// 使用对象做数据,加载区号，并且请求华氏温度，将会发送post请求
$('#tmp').load('us_weather_report.html', { zipcode=02114, units: 'f' });
```

load最后为回调函数，当Ajax请求成功，或未成功，将会调用该函数

## Ajax工具函数
### jQuery.getScript()
将会异步的加载一段脚本
> 同样受到同源的限制

第一个参数为url，第二个参数为运行完成以后将要执行的回调函数
```
jQuery.getScript('js/js_jquery.js', () => {
    $('div').js_jquery();   // 直接使用加载的类库
})
```
底层是使用XMLHttmpRequest对象来获取将要执行的脚本内容，然后将内容添加到script元素内部。

### getJSON()
获取到以后，将会解析为JSON
```
// 假设data.json 包含文本，{'x':33, 'y':44}
jQuery.getJSON('data.json', (data) => {
    // data将会是解析后的对象{x:1, y:2}
})
```
### jQuery.get jQuery.post
```
jQuery.get('./debug.txt', alert);   // 请求get请求，然后弹出警告
```
### jQuery的ajax的数据类型
text    为纯文本
html    为html文件
xml 为xml数据
script  为js文件请求
json    为请求json数据的文件
jsonp   为请求jsonp的

## jQuery的ajax函数
需要传入一个对象
### 一些选项
#### type
指定http的请求方法
get或者post或者delete或者push
#### url
获取的url
#### data
添加到url或者请求体的数据，
#### dataType
预期的类型，即html，script，json，jsonp，xml
#### contentType
指定的请求头
#### timeout
指定的超时时间，如果超过时间，直接取消请求，返回false
#### cache
添加时间戳，防止浏览器缓存
### 回调
#### context
指定回调函数时的上下文对象，即this
#### beforeSend
指定发送ajax请求指定激活的函数
#### success
指定ajax请求成功后的回调函数
#### error
指定ajax请求失败后的回调函数
#### complete
指定请求完成后的函数
### 钩子
#### async
指定同步
#### dataFileter
过滤或者预处理服务器返回的数据

## ajax事件
ajax还会在请求的时候，触发相应的事件
这个用于在请求某些图片的时候，在图片仍旧继续下载的时候，使用相应的时间，提示出图片正在加载中
例如
```
$('#loading_animation').bind({
    ajaxStart: function() {$(this).show()},
    ajaxStop: function() { $(this).hide() }
})
```
# jQuery 选择器
## 简单选择器
例如* 或者p
一个栗子 选取元素在其父节点的子元素中排行第1或第4,第7等元素，含有js单词，不包含a的元素
```
p:nth-child(3n+1):text(js):not(:has(a));
```
## 组合选择器
```
blockquote i // 匹配blockquote里的i元素
ol > li // 选择ol元素下的li元素
```
## 选择器组
```
h1, h2, h3 // 匹配h1 h2 h3的元素
```
## 选取方法
```
var paras = $('p');
paras.first();  // 选取第一个p元素
paras.eq(1);    // 选取第二个p
paras.slice(2, 5);  // 选取3， 4， 5的元素
paras.filter('.note');  // 选取div.note
```
### 将选中的元素集用做上下文
即交并补
```
$('div').find('p'); // 在div中查找p元素
$('#header, #footer').find('p');    // 寻找id为header和footer子元素节点中的p元素
$('h1').next('p');  // 选择h1的兄弟元素p
$('h1').prev(); // 选择h1元素前的兄弟元素
$('#footer').nextAll('p');  // 选择footer元素后的所有p元素
$('#footer').prevAll(); // 选择footer元素前面的所有兄弟元素
$('li').parent();   // 列表元素的父元素
$('a[href]').parents('p');  // 选择含有链接的p元素
$('a[href]').closest('div');    // 选择包含链接的最里层的div元素
```
### 恢复到之前的选中的元素
end()弹出栈
```
// 寻找所有div元素，然后在其中寻找p元素，高亮显示p元素，然后给div加边框
$('div').find('p').addClass('highlight').end().css('border', 'solid black 1px');
```
addSelf 返回一个新的jQuery对象，包含当前选中的所有元素，加上之前选中的。
```
$('div').find('p').andSelf().addClass('highlight').end().end().css('border', 'solid black 1px');
```
# jQuery 插件扩展
插件地址 https://plugins.jquery.com/
> ps 这个插件已经停止了，新的插件，使用npm方式安装。无奈。插件目录处于只读状态，如果下载，使用node.js的npm即包管理器，并且里面的内容已经相当老了。5年的内容，无奈,所以，如果要使用扩展，必须使用npm，无奈，毕竟现在已经8102年了。

jQuery.fn是所有jQuery对象的原型对象。如果给该对象添加一个函数，则该函数会成为一个jQuery的方法。
栗子
```
	jQuery.fn.println = function () {
		// 将所有的参数合并成空格分隔的字符串
		var msg = array.prototype.join.call(arguments, '');
		// 遍历jQuery对象中的每一个元素
		this.each(function() {
			// 将参数的字符串作为文本添加到每一个元素的后面，并添加一个br
			jQuery(this).append(document.createTextNode(msg).append('<br/>'));
		});
		// 返回这个未加修改过的jQuery对象，方便链式调用
		return this;
	}
```
> ps 这个灰常简单，原型链那一套内容，需要注意的是要进行返回该对象，否则无法进行链式调用

使用一下下
```
$('#debug').println('x =', 'x', 'y');
```
即完成了一个jquery的插件的封装
使用jQuery.fx.speeds完成对缓动函数的封装
扩展css选择，使用jQuery.expr[';']完成对css选择的封装
```
jQuery.expr[':'].draggable = function(e) {
    return e.draggable === true;
}
```
使用
```
$('img:draggable');
```
等价于
```
$('img[draggable=true]')
```
上方封装的一个选择器为可拖动的元素
> 当draggable为true的时候，可以对元素进行拖动，这是h5的内容

## 一些注意事项
不要依赖$
插件要返回this
插件有两个或者两个以上的选项，使用对象直接传入
不能污染命名空间，请在jquery上定义一个方法即可，如果有多个方法，请直接使用前缀
如果有事件需要绑定，使用插件名作为命名空间，然后放在插件名中，即，不能使用全局的
如果插件需要使用data()方法关联数据 数据值要在一个对象中。
文件命名需要使用jquery.plugin.js
# jQuery的UI库
https://jqueryui.com/
> ps 该库已经两年未更新了，不过lssues 依旧在回复中，对于库的检查 https://travis-ci.org/jquery/jquery-ui/builds/238029516?utm_source=github_status&utm_medium=notification，已经完全测试通过

一个栗子，日期选择
```
$('input.date').datepicker();
```
将class为data中的input元素统统替换为日期选择组件