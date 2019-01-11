title: node事件循环  EventEmitter 异步I/O Buffer缓冲区 模块
author: Ming ming
tags:
  - node
  - 事件循环
  - EventEmitter
  - 异步I/O
  - Buffer缓冲区
  - 模块
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-25 23:12:00
---
# node.js事件循环
node.js单进程，单线程的程序
每一个api都支持回调
所有的事件机制都是设计模式中的
> 一共是23种设计模式 
http://design-patterns.readthedocs.io/zh_CN/latest/behavioral_patterns/observer.html
一个对象发生改变的时候，将自动通知其他对象，其他对象将相应的做出反应。发生改变的对象为观察目标，被通知的对象为观察者。一个观察目标可以对应多个观察者，而这些观察者之间没有任何联系，可以根据需要增加观察者，使得系统更加容易扩展，依赖关系为一对多，又被称为模型-视图模式

## 事件驱动程序
web server接收到请求，将其关闭，进行处理，然后接着服务下一个web请求。
当请求完成以后，放回处理队列，当到达队列开头的时候，将其结果返回给用户
即非阻塞式I/O 事件驱动I/O
会有一个主循环来监听事件，当检测到事件以后，触发回调函数
### 代码
```
PS C:\Users\mingm\Desktop\test> node main.js
连接成功
数据接收成功
程序执行完毕
PS C:\Users\mingm\Desktop\test>
```
```
// 引入一个 events 模块
var events = require('events');
// 创建 eventEmitter对象
var eventEmitter = new events.EventEmitter();

// 创建connection事件的处理程序
var connectHandLer = function connected() {
	console.log('连接成功');

	// 触发 data_received 事件
	eventEmitter.emit('data_received');
};

// 绑定cinnection事件处理程序
eventEmitter.on('connection', connectHandLer);

// 绑定data_received事件，并完成处理程序的书写
eventEmitter.on(
		'data_received',
		function() {
			console.log('数据接收成功');
		}
	);

// 触发 connection 事件
eventEmitter.emit('connection');

console.log('程序执行完毕');
```
程序的执行过程，先完成各种绑定，触发connection事件以后，寻找绑定的处理程序，为connected()，然后，执行一半，又被触发，data_received事件。寻找绑定的处理程序。一个匿名函数，执行，事件全部完成，执行最后一句，程序执行完毕。
多用户执行的情况下，触发事件以后，若处理程序正被其他用户占用，排队，直到前方全部处理完成以后，接着该用户使用处理程序进行处理。

# EventEmitter
node所有的异步I/O操作在完成的时候都会发送到一个事件到达事件队列。node里的对象能够分发事件
产生的事件的对象都是events.EventEmitter的实例
## EventEmitter类
events模块提供一个对象，它是对事件的触发和事件的监听的封装
```
PS C:\Users\mingm\Desktop\test> node main.js
事件触发
PS C:\Users\mingm\Desktop\test>
```
过五秒后响应
```
// event.js文件
var EventEmitter = require('events').EventEmitter;
var event = new EventEmitter();	// 创建一个event对象
event.on('some_event', function(){console.log('事件触发');});
setTimeout(function(){event.emit('some_event');}, 5000);

```
大概解释一下这段代码
前两句很简单，后两句说一下，event的对象注册了一个事件的监听器。这个事件的监听器为一个匿名函数，事件名称为some_event，当5000秒以后被触发先对象event发送一个事件some_event触发了匿名函数即监听器，监听器被执行。
其中EventEmitter的每个事件由一个事件名和若干参数组成，对于一个事件能有若干的监听器，当事件触发的时候，监听器会被依次调用，事件参数作为回调函数的参数进行传递，需要注意的是，监听器会被依次调用
## error事件
error是一个单独列出来的事件，一般要为其绑定一个监听器，因为node如果抛出error，若没有监听器执行，将会直接退出执行，并返回错误
# Buffer缓冲区
处理TCP或者文件流的时候，需要用到二进制的数据，定义了一个Buffer类，该类用于专门存放二进制数据的缓冲区
## Buffer与字符编码
```
const buf = Buffer.from('ming', 'ascii');	// 声明一个只读的变量

console.log(buf.toString('hex'));

console.log(buf.toString('utf-8'));
```
```
PS C:\Users\mingm\Desktop\test> node main.js
6d696e67
ming
PS C:\Users\mingm\Desktop\test>
```
## 创建一个buffer类,并完成读取写入
```
PS C:\Users\mingm\Desktop\test> node main.js
23456789:;<=>?@ABCDEFGHIJK
23456789:;<=>?@ABCDEFGHIJK
PS C:\Users\mingm\Desktop\test>
```
```
buf = Buffer.alloc(26);
for(var i = 0; i < 26; i++){
	buf[i] = 50 + i;
};
console.log(buf.toString('ascii'));
console.log(buf.toString('utf8'));
```

## 将buffer转换为jsoon
```
PS C:\Users\mingm\Desktop\test> node main.js
{"type":"Buffer","data":[1,2,3,4,5]}
PS C:\Users\mingm\Desktop\test>
```
```
const buf = Buffer.from([0x1, 0x2, 0x3, 0x4, 0x5]);
const json = JSON.stringify(buf);

console.log(json);
```

## 将JSON转换为Buffer
### 一个转换方法JSON.parse
```
> JSON.parse('{"1": 3, "2": [4, 5, 6]}', function (k, v) {
...     console.log(k); // 输出当前的属性名，从而得知遍历顺序是从内向外的，
...     console.log("----------");              // 最后一个属性名会是个空字符串。
...     console.log(v);
... });
1
----------
3
0
----------
4
1
----------
5
2
----------
6
2
----------
[ <3 empty items> ]

----------
{}
undefined
>
```
### 开始转换
```
const buf = Buffer.from([0x1, 0x2, 0x3, 0x4, 0x5]);
const json = JSON.stringify(buf);

console.log(json);


const copy = JSON.parse(	// 调用JSON.parse函数，将字符串转换为对象，后一个参数为转换的函数，转换的时候将会调用
		json,
		(key, value) => {	// 此为es6的语法，一个匿名函数
			console.log(value, '----', !!value, '----', value.type, '-----', value.data);
			return value && value.type === 'Buffer' ? Buffer.from(value.data): value;	// 只留下最后一个进行转换，前面的转换全部被覆盖
		}
	)

// 输出: <Buffer 01 02 03 04 05>
console.log(copy);
```
```
PS C:\Users\mingm\Desktop\test> node main.js
{"type":"Buffer","data":[1,2,3,4,5]}
Buffer ---- true ---- undefined ----- undefined
1 '----' true '----' undefined '-----' undefined
2 '----' true '----' undefined '-----' undefined
3 '----' true '----' undefined '-----' undefined
4 '----' true '----' undefined '-----' undefined
5 '----' true '----' undefined '-----' undefined
[ 1, 2, 3, 4, 5 ] '----' true '----' undefined '-----' undefined
{ type: 'Buffer', data: [ 1, 2, 3, 4, 5 ] } '----' true '----' 'Buffer' '-----' [ 1, 2, 3, 4, 5 ]
<Buffer 01 02 03 04 05>
PS C:\Users\mingm\Desktop\test>
```
## Buffer的合并
```
var buffer1 = Buffer.from('222');
var buffer2 = Buffer.from('3333');
var buffer3 = Buffer.concat([buffer1, buffer2]);
console.log(buffer3.toString());
```
## Stream流
流为一个抽象的接口，
### 从流中读取数据
```
PS C:\Users\mingm\Desktop\test> node main.js
end！
33333333333333333333333333
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');
var data = '';

// 创建可读流
var readerStream = fs.createReadStream('input.txt');

// 设置编码为 utf8
readerStream.setEncoding('UTF8');

// 处理流事件 data事件
readerStream.on('data', (chunk) => {data += chunk;});	// 遇到数据读取，将读取到的内容赋值给data

// 处理流事件 end事件
readerStream.on('end', () => {console.log(data);});	// 将读取到的保存到内存中的数据打印出来

// 处理事件 error
readerStream.on('error', (err) => {console.log(err.stack);});	// 处理error事件，将错误输出，避免程序的运行中断

console.log('end！');
```
### 写入流
```
PS C:\Users\mingm\Desktop\test> node main.js
程序执行完毕
写入完成
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');
var data = '这是一段示例';

// 创建一个可以写入的流，写入到文件output.txt中
var writerStream = fs.createWriteStream('output.txt');

// 使用 utf8 编码写入数据
writerStream.write(data, 'UTF8');

// 标记文件末尾
writerStream.end();

// 处理流事件 --> data, end, add error
writerStream.on('finish', () => {console.log('写入完成');});

writerStream.on('error', () => {console.log(err.stack);});

console.log('程序执行完毕');


```
### 管道流
把两个文件之间建立流，让一个文件的数据流向另外一个文件
```
PS C:\Users\mingm\Desktop\test> node main.js
程序执行完毕
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');

// 创建一个可读流
var readerStream = fs.createReadStream('input.txt');

// 创建一个可写流
var writerStream = fs.createWriteStream('output.txt');

// 管道读写操作
// 将两个流通过管道连接起来
readerStream.pipe(writerStream);

console.log('程序执行完毕');

```

这里需要注意的是，由于流的影响，导致在操作的时候，会覆盖掉要写入文件的内容，原先的内容会被覆盖
### 链式流
```
PS C:\Users\mingm\Desktop\test> node main.js
文件压缩完成
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');
var zlib = require('zlib');

// 压缩 input.txt文件为 input.txt.gz
fs.createReadStream('input.txt')	// 创建一个可读流
	.pipe(zlib.createGzip())		// 将创建的可写流和压缩流连接
	.pipe(fs.createWriteStream('input.txt.gz'));	// 在创建可写流，将三个流连接到一起

console.log('文件压缩完成');
```

### 内容未被覆盖的写入
```
var fs = require('fs');
var read = fs.createReadStream('output.txt');
var write = fs.createWriteStream('input.txt');
read.pipe(write);
console.log('执行完毕');
```
具体详细，请查文档
https://nodejs.org/api/fs.html#fs_fs_createwritestream_path_options
https://nodejs.org/api/fs.html#fs_file_system_flags
文档写的很详细，后面的参数为一个对象，通过对象即可进行修改
# 模块
模块之前已经阐述过一部分，这里阐述服务器端的模块
## 服务器端的模块
node中自带了一个http模块，在代码中请求他，并将返回值赋值给本地变量。即本地变量变成了一个拥有所有http模块所提供的公共方法的对象。
node中有四个模块，（原生模块和三种文件模块）
### 从文件模块的缓存中添加
原生模块和文件模块优先级不同，都会优先从文件模块的缓存中加载以及存在的模块
### 从原生模块加载
原生模块的优先级低于文件模块缓存的优先级。原生模块也有缓存区
### 从文件加载
这个上一篇以及阐述完成，不在阐述