title: node工具模块
author: Ming ming
tags:
  - node.js
  - 工具模块
  - Path
  - 监控器类
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-28 01:29:00
---
 Node.js工具模块
node工具模块分为OS，Path， Net， DNS， Domain模块
# OS
## 字节顺序
字节顺序，称为端序和尾序，是跨越多字节程序对象的储存规则
如果最低有效位在最高位的前面，则为小端序，反过来为大端序
### 端的起源
来自于格列佛游记，中的水煮蛋的大端和小端。
### 字节序有什么用
读取的时候要用，即处理器从内存中进行读取的时候，需要字节序，是大端序，还是小端序
其中大端序是人类读写数值需要的，大的在前，小的在后。
小端序是机器的读法，正好相反
### 为什么会有小端序
因为计算机读取的时候是从低电位进行读取，计算的时候也是从低位进行计算（人类也是这样）这样的效率一般会比较高。
### 字节顺序
对于单一字节，处理器以相同顺序处理预元（bit），因此单字节的传输和存放是一样的
对于多字节，在不同处理器的存放方式有两种。
#### 大端序
最高为字节储存在最低的内存地址处。下一个字节储存在后面的地址处（即跟高的内存地址）
#### 小端序
反过来即可
# Path模块
# Domain模块
简化代码的异常处理
该模块，将多个处理的模块分为一组，然后进行处理
隐式绑定：把在上下文中定义的变量，自动进行绑定
显式绑定：把不在上下文定义的变量，通过代码进行绑定
> 需要使用一个emitter.emit http://nodejs.cn/api/events.html#events_emitter_emit_eventname_args
按照监听器的注册顺序，同步调用

> emitter.removeAllListeners 移出绑定的监听器
> http://nodejs.cn/api/events.html#events_emitter_removealllisteners_eventname

> domain.run 在其域的上下文内，运行提供的函数, 所有的都隐式绑定
> http://nodejs.cn/api/domain.html#domain_domain_run_fn_args

> domain.remove 移出监听器
> http://nodejs.cn/api/domain.html#domain_domain_remove_emitter

```
var EventEmitter = require('events').EventEmitter;
var domain = require('domain');	// 域

var emitter1 = new EventEmitter();	// 创建一个监听器的类,这是一个和监听器有关的类

// 创建域
var domain1 = domain.create();

domain1.on('err', (err) => {	// 绑定一个错误域,如果这个时候执行err事件，则处理回调函数
	console.log('domain1 处理这个错误' + err.message);
});

// 显示绑定
domain1.add(emitter1);	// 将监控器的类和域进行绑定

emitter1.on('error', (err) => {	// 添加监听器的error事件的回调函数
	console.log('监听器处理错误' + err.message);
});

emitter1.emit('error', new Error('通过监听器来处理'));	// 触发error事件，首先运行error的回调函数，接着运行new Error事件

emitter1.removeAllListeners('error');	// 移出监听器类绑定的所有的事件

emitter1.emit('error', new Error('通过正常的 domainl来进行处理'))	// 由于上一步已经移出了监听器，所以通过正常的创建域中的错误的处理进行处理

var domain2 = domain.create();	// 创建一个新的 domain2 的域

domain2.on('error', (err) => {	// 将该域和事件进行绑定
	console.log('domain2 来进行处理' + err.message);
});

// 隐式绑定
domain2.run(() => {	// 创建一个域的运行空间
	var emitter2 = new EventEmitter();	// 在域的运行空间内创建一个新的监控器的类
	emitter2.emit('error', new Error('由domain2处理'));	// 由于监控器的类没有进行绑定，所以上下文寻找error错误的处理，找到第28行，对于error错误的处理，运行回调函数
});

domain1.remove(emitter1);	// 移出域绑定的错误
emitter1.emit('error', new Error('由于未进行绑定，程序遇到执行错误'));	// 


```

```
PS C:\Users\mingm\Desktop\test> node main.js
监听器处理错误通过监听器来处理
events.js:167
      throw er; // Unhandled 'error' event
      ^

Error: 通过正常的 domainl来进行处理
    at Object.<anonymous> (C:\Users\mingm\Desktop\test\main.js:24:24)
    at Module._compile (internal/modules/cjs/loader.js:689:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:700:10)
    at Module.load (internal/modules/cjs/loader.js:599:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:538:12)
    at Function.Module._load (internal/modules/cjs/loader.js:530:3)
    at Function.Module.runMain (internal/modules/cjs/loader.js:742:12)
    at startup (internal/bootstrap/node.js:266:19)
    at bootstrapNodeJSCore (internal/bootstrap/node.js:596:3)
Emitted 'error' event at:
    at EventEmitter.emit (domain.js:455:12)
    at Object.<anonymous> (C:\Users\mingm\Desktop\test\main.js:24:10)
    at Module._compile (internal/modules/cjs/loader.js:689:30)
    [... lines matching original stack trace ...]
    at bootstrapNodeJSCore (internal/bootstrap/node.js:596:3)
PS C:\Users\mingm\Desktop\test>
```