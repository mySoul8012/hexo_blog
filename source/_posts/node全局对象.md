title: node全局对象 文件系统
author: Ming ming
tags:
  - node
  - 全局对象
  - 文件系统
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-27 01:54:00
---
node全局对象
js中一个对象，该对象为全局对象。
在客户端中，该对象为whindow，由this进行指向
node中的全局对象为global，所有的全局变量，除了自己以外都是global对象的属性
# 全局对象和全局变量
全局变量是全局对象的宿主
## _filename
表示当前正在执行的脚本名，将会输出文件位置所在的绝对路径。
如果在模块中，返回的是模块文件的路径。
```
PS C:\Users\mingm\Desktop\test> node main.js
C:\Users\mingm\Desktop\test\main.js
PS C:\Users\mingm\Desktop\test>
```
```
// 输出全局变量 __filename的值
console.log(__filename);
```
## __dirname
表示当前执行脚本所在的目录
```
PS C:\Users\mingm\Desktop\test> node main.js
C:\Users\mingm\Desktop\test
PS C:\Users\mingm\Desktop\test>
```
```
console.log(__dirname);
```
## setTimeout
```
function printHello() {
	console.log('hello word');
};

// 两秒后执行以上函数
setTimeout(printHello, 2000);	// 该函数返回一个代表定时器的句柄值
```
```
function printHello() {
	console.log('hello word');
};

// 两秒后执行以上函数
setTimeout(printHello, 2000);	// 该函数返回一个代表定时器的句柄值
```

## clearTimeout
停止一个计时器
## settlnterval
一个计时器会不断的调用，返回的是一个代表定时器的句柄值
```
function printHello() {
	console.log('hello word!');
};

// 每两秒后循环执行以上函数
setInterval(printHello, 2000);
```
```
PS C:\Users\mingm\Desktop\test> node main.js
hello word!
hello word!
hello word!
hello word!
hello word!
hello word!
hello word!
hello word!
hello word!
```
## process 
一个全局变量，即global对象的属性
用于描述当前node进程状态的对象。
```
process.on('exit', (code) => {
	// 下方代码不会执行
	setTimeout(() => {console.log('该代码不会执行');}, 0);

	console.log('退出码为', code);
});
console.log('程序执行结束');
```
```
PS C:\Users\mingm\Desktop\test> node main.js
程序执行结束
退出码为 0
PS C:\Users\mingm\Desktop\test>
```
## 一个示例文件
```
// 输出到终端
process.stdout.write('hello world!' + '\n');	// 创建一个写入流，通过写入流，输出到终端

// 通过参数读取
process.argv.forEach((val, index, array) => {console.log(val + index + array)});

// 获取执行路径
console.log(process.execPath);

// 平台信息
console.log(process.platform);
```
```
PS C:\Users\mingm\Desktop\test> node main.js
hello world!
C:\Program Files\nodejs\node.exe0C:\Program Files\nodejs\node.exe,C:\Users\mingm\Desktop\test\main.js
C:\Users\mingm\Desktop\test\main.js1C:\Program Files\nodejs\node.exe,C:\Users\mingm\Desktop\test\main.js
C:\Program Files\nodejs\node.exe
win32
PS C:\Users\mingm\Desktop\test>
```
```
PS C:\Users\mingm\Desktop\test> node main.js
{ rss: 18874368,
  heapTotal: 6066176,
  heapUsed: 3677376,
  external: 8272 }
PS C:\Users\mingm\Desktop\test>
```
```
// 输出内存使用情况
console.log(process.memoryUsage());
```

# node文件系统
node提供一组类似unix的标准文件操作api
## 异步和同步
异步的方法后面会有一个回调函数
> 貌似回调多了以后会产生回调地狱

```
var fs = require('fs');

// 异步读取
fs.readFile('input.txt', (err, data) => { err?console.error(err):true;
	console.log('异步读取' + data.toString());
});

```
```
PS C:\Users\mingm\Desktop\test> node main.js
异步读取33333333333333333333333333333333333333333
PS C:\Users\mingm\Desktop\test>
```
> ps 减少异步，让世界更美好一点\(^o^)/
> 建议回调使用箭头函数，要不然很容易产生回调地狱,让人抓狂

## 打开文件
```
// 打开input.txt文件进行读写
var fs = require('fs');

// 异步打开文件
console.log('准备打开文件!');
fs.open('input.txt', 'r+', (err, fd) => {err?console.log(err):console.log('文件打开成功!');});

```
```
PS C:\Users\mingm\Desktop\test> node main.js
准备打开文件!
文件打开成功!
```

## 获取文件信息
fs模块下的stat方法
判断是否是文件
```
var fs = require('fs');

fs.stat('input.txt', (err, stats) => {console.log(stats.isFile());});
```
```
PS C:\Users\mingm\Desktop\test> node main.js
true
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');

console.log('准备打开文件!');
fs.stat('input.txt', (err, stats) => {err?console.log(err):console.log(stats);
	console.log('读取文件信息成功！');
	// 检测文件类型
	console.log(stats.ifFile());
	console.log(stats.isDirectory());
});
```
```
PS C:\Users\mingm\Desktop\test> node main.js
准备打开文件!
Stats {
  dev: 982976588,
  mode: 33206,
  nlink: 1,
  uid: 0,
  gid: 0,
  rdev: 0,
  blksize: undefined,
  ino: 12103423998567884,
  size: 41,
  blocks: undefined,
  atimeMs: 1532607165034.9072,
  mtimeMs: 1532606924599.2798,
  ctimeMs: 1532606924599.2798,
  birthtimeMs: 1532606914067.3428,
  atime: 2018-07-26T12:12:45.035Z,
  mtime: 2018-07-26T12:08:44.599Z,
  ctime: 2018-07-26T12:08:44.599Z,
  birthtime: 2018-07-26T12:08:34.067Z }
读取文件信息成功！
C:\Users\mingm\Desktop\test\main.js:7
        console.log(stats.ifFile());
                          ^

TypeError: stats.ifFile is not a function
    at fs.stat (C:\Users\mingm\Desktop\test\main.js:7:20)
    at FSReqWrap.oncomplete (fs.js:159:5)
PS C:\Users\mingm\Desktop\test>
```
## 写入文件
```
var fs = require('fs');

console.log('准备写入文件');
fs.writeFile('input.txt', '我是异步写入的内容', (err) => { err?console.log(err):false;
	console.log('数据写入成功！');
	console.log('----我是分割线----');
	console.log('开始读取写入的数据');
	fs.readFile('input.txt', (err, data) => {
		err?console.log(err):false;
		console.log('异步读取数据为' + data.toString());
	});
});
```
```
PS C:\Users\mingm\Desktop\test> node main.js
准备写入文件
数据写入成功！
----我是分割线----
开始读取写入的数据
异步读取数据为我是异步写入的内容
PS C:\Users\mingm\Desktop\test>
```
## 读取文件
在异步的情况下读取文件
参数 http://nodejs.cn/api/fs.html#fs_event_open_1
使用的fs.read http://nodejs.cn/api/fs.html#fs_event_open_1
```
var fs = require('fs');
var buf = new Buffer.alloc(1024);	// 创建一个缓冲区

console.log('准备打开已存在的文件');
fs.open('input.txt', 'r+', (err, fd) => {
	if (err) {
		console.log(err);
	};
	console.log('文件打开成功');
	console.log('准备读取文件');
	fs.read(fd, buf, 0, buf.length, 0, (err, bytes) => {
		if (err) {
			console.log(err);
		};
		console.log(bytes + '字节被读取');

		// 输出读取的字节
		if (buyes > 0) {
			console.log(buf.slice(0, bytes).toString());
		}
	});
});
```
```
PS C:\Users\mingm\Desktop\test> node main.js
准备写入文件
数据写入成功！
----我是分割线----
开始读取写入的数据
异步读取数据为我是异步写入的内容
PS C:\Users\mingm\Desktop\test>
```
Buffer.slice http://nodejs.cn/api/buffer.html
返回一个指向相同原始内存的新建的 Buffer
```
PS C:\Users\mingm\Desktop\test> node main.js
准备打开已存在的文件
文件打开成功
准备读取文件
27字节被读取
我是异步写入的内容
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');
var buf = new Buffer.alloc(1024);	// 创建一个缓冲区

console.log('准备打开已存在的文件');
fs.open('input.txt', 'r+', (err, fd) => {
	if (err) {
		return console.log(err);
	};
	console.log('文件打开成功');
	console.log('准备读取文件');
	fs.read(fd, buf, 0, buf.length, 0, (err, bytes) => {
		if (err) {
			console.log(err);
		};
		console.log(bytes + '字节被读取');

		// 输出读取的字节
		if (bytes > 0) {
			console.log(buf.slice(0, bytes).toString());
		}
	});
});
```
## 关闭文件
在异步的模式下关闭文件
```
PS C:\Users\mingm\Desktop\test> node main.js
准备打开文件!
文件打开成功！
准备读取文件!
我是异步写入的内容
文件关闭成功
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');
var buf = new Buffer.alloc(1024);


console.log('准备打开文件!');
fs.open('input.txt', 'r+', (err, fd) => {
	if (err) {
		return console.log(err);
	};
	console.log('文件打开成功！');
	console.log('准备读取文件!');
	fs.read(fd, buf, 0, buf.length, 0, (err, bytes) => {
		if (err) {
			console.log(err);
		};

		// 输出能读取的字节
		if(bytes > 0) {
			console.log(buf.slice(0,bytes).toString());
		};

		// 关闭文件
		fs.close(fd, (err) => {
			if(err) {
				console.log(err);
			};
			console.log('文件关闭成功');
		});
	});
});

```
## 截取文件
在异步的模式下截取文件
fs.ftruncate(fd[, len], callback) 
http://nodejs.cn/api/fs.html#fs_fs_ftruncate_fd_len_callback
```
var fs = require('fs');
var buf = new Buffer.alloc(1024);

console.log('准备打开文件!');
fs.open('input.txt', 'r+', (err, fd) => {
	if (err) {
		return console.error(err);
	};
	console.log('文件打开成功！');
	console.log('截取了10字节后的文件内容。');

	// 截取文件
	fs.ftruncate(fd, 10, (err) => {
		if (err) {
			console.log(err);
		};
		console.log('文件截取成功');
		console.log('读取相同的文件');
		fs.read(fd, buf, 0, buf.length, 0, (err, bytes) => {
			if (err) {
				console.log(err);
			};

			// 仅输出读取的字节
			if (bytes > 0) {
				console.log(buf.slice(0, bytes).toString());
			}

			// 关闭文件
			fs.close(fd, (err) => {
				console.log(err);
			});
			console.log('文件关闭成功！');
		});
	});
});
```
```
PS C:\Users\mingm\Desktop\test> node main.js
准备打开文件!
文件打开成功！
截取了10字节后的文件内容。
文件截取成功
读取相同的文件
我是异�
文件关闭成功！
null
PS C:\Users\mingm\Desktop\test>
```
## 删除文件
```
PS C:\Users\mingm\Desktop\test> node main.js
准备删除文件！
文件删除成功！
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');

console.log('准备删除文件！')
fs.unlink('input.txt', (err) => {
	if (err) {
		return console.log(err);
	};
	console.log('文件删除成功！');
});
```
## 创建目录
```
PS C:\Users\mingm\Desktop\test> node main.js
创建目录 ./tmp/test
{ [Error: ENOENT: no such file or directory, mkdir 'C:\Users\mingm\Desktop\test\tmp\test']
  errno: -4058,
  code: 'ENOENT',
  syscall: 'mkdir',
  path: 'C:\\Users\\mingm\\Desktop\\test\\tmp\\test' }
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');

console.log('创建目录 ./tmp/test');
fs.mkdir('./tmp/test', (err) => {
	if (err) {
		return console.log(err);
	};
	console.log('目录创建成功！');
});
```
## 读取目录
forEach方法没有找到一个 官方文档，貌似目前找不到
```
PS C:\Users\mingm\Desktop\test> node main.js
查看 /tmp 目录
{ [Error: ENOENT: no such file or directory, scandir 'C:\Users\mingm\Desktop\test\tmp']
  errno: -4058,
  code: 'ENOENT',
  syscall: 'scandir',
  path: 'C:\\Users\\mingm\\Desktop\\test\\tmp' }
PS C:\Users\mingm\Desktop\test>
```
```
var fs = require('fs');

console.log('查看 /tmp 目录');
fs.readdir('./tmp/', (err, files) => {
	if (err) {
		return console.log(err);
	};
	files.forEach((file) => {	// 这个方法目前没有找到，联系到客户端的方法，貌似是合并的意思
		console.log( file );	
	});
});
```