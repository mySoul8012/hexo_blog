title: jQuery(一)
author: Ming ming
tags:
  - jQuery
  - 库
categories:
  - 前端
  - js
  - 客户端js
date: 2018-08-20 03:55:00
---
jquery
jquery为一种库，属于最基础的一个库，伴随着h5的到来，很多jquery的规则直接融入到了规则本身了，直接使用原生的js也能达到相同的目的。虽然如此，不过依旧要继续。
# jquery介绍
官网：https://jquery.com/
github: https://github.com/jquery/jquery
blog：https://blog.jquery.com/
学习中心：https://learn.jquery.com/  推荐使用学习中心学习jquery
文档：https://api.jquery.com/   推荐使用文档进行相关的查询
封装jquery插件 http://plugins.jquery.com/  官网推荐使用npm包的方式，带上jquery-plugin
相关插件：npm包 https://www.npmjs.com/search?q=keywords:jquery-plugin  jquery 官方插件 http://plugins.jquery.com/ 不过目前处于不更新的状态，不推荐使用内部的插件，因为很可能没有作者维护了。并且已经处于自读的方式，不推荐使用，推荐使用npm的方式，使用jquery的相关插件
jquery官方推荐图书 https://www.packtpub.com/web-development/learning-jquery-fourth-edition
https://www.manning.com/books/jquery-in-action-third-edition
https://www.syncfusion.com/ebooks/jquery
一本都看不懂。。。
js基金会 https://js.foundation/ 是滴，js也拥有基金会了，和linux一样
目前js基金会下属项目 https://js.foundation/community/projects
好啦，有点小乱。大概也就这些了。
其中jquery的最出色的地方在于对元素的选择。
## jQuery Mobile 介绍
jquery mobile 属于移动端的js库 
> ps 移动端的兼容问题，没有客户端的兼容问题的严重

官网 https://jquerymobile.com/
文档 https://api.jquerymobile.com/
> ps 该项目博客保留在2017年，提交截止在去年，测试状态不通过 https://travis-ci.org/jquery/jquery-mobile/builds/313129853?utm_source=github_status&utm_medium=notification

╮(╯▽╰)╭
唉

# 下载jquery
打开 https://jquery.com/download/
在开发和调试的时候使用未压缩的文件，在上线的时候使用压缩的文件，节省空间。
## 使用npm安装
```
npm install --save jquery 
```
上方将会保存在依赖项中
将会在
```
node_modules/jquery/dist/
```
中找到生产环境的版本和开发版本

## 使用bower
> bower一个类似于npm的包管理

```
bower install jquery
```
将会在
```
bower_components/jquery/dist/
```
中找到生产环节版本和开发版本

## 关于测试
浏览器的兼容测试，在微软提供的在线测试进行测试
https://developer.microsoft.com/en-us/microsoft-edge/

以及chrome官方提供的https://developers.google.com/web/tools/lighthouse/?hl=zh-cn

> 谷歌web开发者 https://developers.google.com/web/ 里面有很多新奇好玩的东东

## 关于CDN
由于是国内的缘故，境外的源无法使用，所以使用国内的缓存服务
### 由bootcdn提供的jquery
https://www.bootcdn.cn/jquery/
这个使用比较多
### 由百度云CDN提供
貌似已经不同步了。
### 又拍云提供
http://jscdn.upai.com/
同样版本也不同步了
### 七牛云提供
http://www.staticfile.org/
同样版本稳定在2.0
### 谷歌
因为某些缘故，无法使用
https://developers.google.com/speed/libraries/
### 总结
唯一一个能用的只有bootcdn了。无奈。
很无奈，不可控的服务，唉
## jquery基础
jquery定义了一个全局函数，由于使用频繁定义了一个别名即

```
$
```

其中$和jQuery()为相同的。

> 如果在自己代码中使用$作为变量，为了避免冲突，通过调用
jQuery.noConflict()
释放$变量，让其指向原始值

其拥有两个名字的全局方法为jquery的核心查询方法。
即

```
var divs = $('div');
```
### 获得全部元素
> 由于需要引入库，在本地写及其的不方便，如果学习直接在线书写 http://jsfiddle.net/ 即可 或者 https://codepen.io 即可 下面使用http://jsfiddle.net/

页面引入jquery
```
https://cdn.bootcss.com/jquery/3.3.1/jquery.js
```
书写获得全部div
<script async src="//jsfiddle.net/melovemingming/3uw4y5tz/8/embed/"></script>
```
var divs = $('div');
```
或者
```
var divs = jQuery('div')
```
其中
```
$ 和 jQuery 
```
等价
其中Jquery为工厂函数，将会返回一个新创建的对象。
#### 栗子
找到所有拥有details类的p元素，将其高亮显示，
```
$('p.datails').css('background-color', 'yellow')
```
### jQuery()函数
在Jquery中为最终要的为Jquery()方法，即$
#### 选择的方式
##### 第一种
传递css选择器（字符串）给$()方法。通过这种方法调用，$()会返回当前文档中匹配该选择器的元素集。
##### 第二种
传递一个Element，Document或Window对象给$()方法，$()将会将其封装成对象并返回。即，可以通过这种方式完成通过Jquery方法操作元素，而不使用原生DOM的方法。
即
```
$(document) 或 $(this)
```
使用这种方法可以完成对节点的操作
##### 第三种
传递字符串文本给$()方法，jQuery将会根据传入的文本创建好HTML元素，然后将其封装为jQuery对象返回。
> ps 在这种情况下，不能使用纯文本，因为jQuery会将纯文本当成选择器解析。必须为html标签，还需有一个尖角括号

通过这种方式调用，将会接受第二可选参数，传递Document对象指定与所创建元素相关联的文档。
即
```
var img = $('<img/>', 
		{
			src:url,	// 创建一个属性,该属性为src
			css: { borderWidth:5 },	// 创建css样式
			click: handleClick	// 创建事件处理程序
		}
	);
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/08/19/0.png)
将会返回一个jquery对象

##### 第四种
传入一个函数给$()方法。此时当文档加载完毕并且DOM可操作时，传入的函数将会被调用。
即
```
jQuery(
    () => {}
)
```
上方当文档加载完毕的时候将会执行一个匿名函数

### 一些术语
#### 函数
jQuery函数可以创建jQuery对象，用来注册DOM就绪时需要调用的处理程序。即全局jQuery对象
#### 对象
jQuery对象有jQuery函数返回的对象，一个jQuery对象表示一组文档元素，即jQuery集，包装集，jQuery结果

#### 选中元素
传递css选择器给jQuery函数时，将会返回jQuery对象表示匹配该选择器的文档元素集。
#### jQuery函数
hQuery函数为定义在jQuery命名空间中的函数，或者静态方法
#### jQuery方法
jQuery方法是由jQuery函数返回的jQuery对象的方法。
### 查询与查询结果
$()返回值为一个jQuery对象，jQuery对象为类数组。
即
```
$('body').length;   // 将会返回文档中该元素的数量，从1开始
$('body')[0];   // 等同于 document.body
```
> 同样的，size替代length属性，get()替代方括号索引，用toArray方法将jQuery对象转为真实数组

```
var bodyscript = $('script', document.body);
bodyscript.selector;	// 创建对象时的选择器字符串,即script
bodyscript.context;	// 上下文对象 即body、
bodyscript.jquery; // 版本号
```

#### each()
each()类似于原生的for循环
```
// 下方将会获取所有的dvi元素，并将其打印出来
$('div').each(
		(idx) => {
			console.log(this);
		}
	);
```
类似于原生的forEach()方法，直接使用this关键字指代其遍历到的对象。
> ps map()方法和原生的map一致。（由于时间问题，规定吸取了jquery的一部分），都为将对象的属性每次传入回调函数

一个栗子
```
$('div').each(() => {	// 选择div元素
	if ($(this).is(':hidden')) return;	// 如果是隐藏元素，直接跳过
})
```

# getter 和 setter
jQuery上最简单，最常见的操作为获取(get),或者设置(set)的HTML属性。
jQuery将会使用同一个方法既当getter又做setter，而不是定义一对方法，如果传入一个新值给方法，则它将设置此值。
用做setter时，这些方法会给jquery对象中的每个元素设置值。然后返回对象，使用链式调用
## 获取和设置HTML属性
attr()方法为jQuery中用于HTML属性的getter/setter
一个栗子
```
$('form').attr('action');	// 将会获取到form元素的action属性
$('#icon').attr('src', 'icon.gif');	// 设置src属性
$('#banner').attr({src:"bannner.gif", alt:'Advertisement', width:720, height:64});	// 设置属性
$('a').attr('target', '_blank');	// 将所有的链接在新窗口打开
$('a').attr('target', () => { // 进行选择，使得站内链接在本窗口打开，让站外的链接在新窗口打开
	if (this.host = location.host) return '_self';
	else return "_blank"; 
});
```
## 获取和设置css属性
使用的是css()方法。设置样式的时候，css是直接添加到style属性中
```
$('h1').css('font-weight');	// 获取第一个h1的字体宽度
$('h1').css('fontWeight');	// 同理
$('h1').css('font');	// 这个错误，不能使用混合样式
$('h1').css('font-variant', 'smallcaps');	// 设置css
$('div.note').css('border', 'solid black 2px');	//选择clas为note的元素，然后设置css
$('h1').css({
	background:"white",	// 一次性的设置多个属性,由于是对象，所以这里使用逗号
	textColor:"white",	
	fontVariant:"small-caps"
});
// 使用函数
$('h1').css('fongt-size', (i, curval) => { return Math.round(1.25*parseInt(curval)); });	// 第一个参数为计数，第二个参数为其属性值,parseInt 的作用为获取其数字,其中jquery会自动加上单位

```
## 获取和设置css类
```
// 添加css类
$('h1').addClass('hilite');	// 给所有的h1元素添加一个类
$('h1+p').addClass('hilite first');	//给p的父元素为h1的元素添加两个类
$('h1').addClass((n) => { return "section" + n; });	// 其中n表示当前遍历到的索引值
// 删除css类
$('p').removeClass("hilite");	// 删除一个类
$('p').removeClass('hilite first');	// 删除多个类
$('p').removeClass((n) => { return "section" + n });	// 通过函数删除
$('p').removeClass();	//删除所有的自定义类
// 切换css类,即第一次执行显示，第二次执行消失
$('tr:odd').toggleClass('oddrow');	// 匹配列表中的奇数序列的元素，然后进行添加
$('h1').toggleClass('big bold');	//切换为这个类
$('h1').toggleClass((n) => { return "big bold h1-" + n });	//使用函数
$('h1').toggleClass("hilite", true);	// 添加
$('h1').toggleClass('hilite', false);	// 移出
// 检测css类
$('p').hasClass('first');	// 确定是否有该类
$('#lead').is('.first');	// 同理
$('#lead').is('.first.hilite');	// 是否有两个类
```
is为判断，当是的时候选择true，否的时候选择false


## 获取设置表单值
```
$('#surname').val();	// 获取surname的文本域的值
$('#usstate').val();	// 获取值
$('select#extras').val();	// 选择select 并且id为extras的元素
$('input:radio[name=ship]:checked').val();	// 获取选中的单选按钮的值
$('#email').val('设置域');	// 给文本域进行设置
$('input:checkbox').val(['opt1', 'opt2']);	// 选中带有这些值的框
$('input:text').val(() => { return this.defaultValue; });	// 将其设置为默认值

```
## 设置和获取元素内容
```
var title = $('head title').text();	// 获取类为head title的元素内容，类似于原生的textContent
var headline = $('h1').html();	// 获取第一个h1元素的html 类似于原生的innerHTML
$('h1').text((n, current) => { return "&" + (n+1) + ":" + current });	// 添加章节，使用函数
```

## 获取和设置元素的位置的高和宽
```

var elt = $('#sprite');	// 选择元素
var position = elt.offset();	// 获取当前位置,相对于文档，不是相对于视窗
position.top += 100;	// 改变y的值
elt.offset(position);	// 设置新位置
// 将所有的<h1>元素向右移动，移动的距离取决于它们在文档中的位置
$('h1').offset((index, curpos) => { return { left: curpos.left + 25*index, top:curpos.top }; });	// 进行偏移
// 获取高度
var body = $('body');	
var contentWidth = body.width();	// 获取w3c盒子的高度
var paddingWidth = body.outerWidth();	// 获取ie盒子的高度
var borderWidth = body.outerWidth(true);	// 加上margin的宽度
var padding = paddingWidth - contentWidth;	// 左padding和右padding的值
var borders = borderWidth - paddingWidth;	// 左border和右border的和
var margins = marginWidth - borderWidth;	// 左margin和右margin的和
// 根据页面数 n 来滚动窗口。n 可以为分数 或 负数
function page(n) {
	var w = $(window);	// 将window封装为jquery对象
	var pagesize = w.height();	// 得到页面的大小（文档的大小）
	var current = w.scrollTop();	// 得到当前滚动条的位置
	w.scrollTop(current + n*pagesize);	// 设置新的滚动条的位置
}
```

## 获取和设置元素的位置高宽
```
$('div').data('x', 1);	// 此不在DOM上显示，会直接作为属性附上
$('div').removeData('x');	// 移出数据
var x = $('div').data('x');	// 获取一些数据
```
# 修改文档结构
## 插入和替换元素
下面是正着
```
$('h1').append('<br/>');	// 将br作为h1的子节点，在尾部
$('h1').prepend('<a>');	// 在起始位置添加标签 ，依旧为子节点
$('h1').before('<hr/>');	// 在每个h1的前面添加水平线
$('h1').after('<hr/>');	// 在每个h1的后面添加标签
$('h1').replaceWith('<br/>');	// 替换h1元素为br元素
$('h2').each( () => {	// 进行遍历
		var h2 = $(this);	// 获取当前遍历到的元素
		h2.replaceWidth('<h1>' + h2.html() + '</h1>');	// 将目标元素的内容进行替换
	});
```
下面是倒着
```
$('<br>').appendTo('#log');	// 将br添加到#log中，到末尾
$(document.createTextNode("&")).prependTo('h1');	// 给所有的h1添加到起始处
$('<hr/>').insertAfter('h1');	// 在所有的h1后面插入水平线
$('<br>').replaceAll('hr');	// 将hr替换为br
```

## 复制元素
```
// 给文档结尾添加一个带有linklist id 的新div
$(document.body).append('<div id="linklist"><h1>List of Links</h1></div>');
// 将文档中的所有链接复制并插入该新div中
$('a').clone().appendTo('#linklist');	// clone不会复制事件处理程序
// 在每一个链接后插入<br>元素，使其能独立显示
$("#linklist > a").after('<br/>');
```
## 包装元素
```
// 用<i>元素包装所有的<h1>元素
$('h1').wrap(document.createElement('i'));	// 产生<i><h1></h1></i>
// 包装所有<h1>元素的内容，使用字符串参数更简单
$('h1').wrapInner('<i/>');	// 产生 <h1><i></i></h1>
// 将第一个段落包装在一个锚点和div里
$('body > p:first').wrap('<a name="lead"><div class="first"></div></a>');
// 将所有的其他段落包装在另一个div里
$('body > p:not(:first)').warpAll('<div class="rest"></div>')
```
