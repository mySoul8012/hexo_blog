title: Node.js多进程
author: Ming ming
tags:
  - Node.js多进程
  - fork()
  - spawn()
  - exec()
categories:
  - 前端
  - js
  - 服务器端js
date: 2018-07-30 20:43:00
---
Node.js多进程
Node.js单线程模式运行的，使用事件处理并发。
# exec()
使用子进程的执行命令,缓存子进程的输出。并将子进程的输出以回调函数参数的形式进行返回
## process.argv() 
### 当参数为0时
是node的文件绝对地址
### 当参数为1时
是该文件的绝对地址
### 当参数为2时
是命令第一个参数。 
## child_process.exec
回调函数有三个选项，error, stdout, stderr
error 为程序执行的错误，正常执行会返回一个null
stdout 为程序的正常输出
stderr 为程序错误输出
```
/*master.js*/
const fs = require('fs');
const child_process = require('child_process');
 
for(var i=0; i<3; i++) {
	var count = 0;
    var workerProcess = child_process.exec('node support.js ' +i, function (err, std, stderr) {
        if (err) {
            console.log(err.stack);
            console.log('Error code: '+err.code);
            console.log('Signal received: '+err.signal);
        }
        console.log('---------------------');
        console.log(i);
        console.log('stdout: ' + std);
        console.log('stderr: ' + stderr);
    });
 
    workerProcess.on('exit', function (code) {
        console.log('子进程已退出，退出码 '+code);
        console.log('执行顺序' + count++);
    });
}
```
```
/*support.js*/
/*support.js*/
console.log("进程 " + process.argv[2] + " 执行。" );
```
执行结果
```
PS C:\Users\mingm\Desktop\test> node master.js
子进程已退出，退出码 0
执行顺序0
---------------------
3
stdout: 进程 0 执行。

stderr:
子进程已退出，退出码 0
执行顺序1
---------------------
3
stdout: 进程 1 执行。

stderr:
子进程已退出，退出码 0
执行顺序2
---------------------
3
stdout: 进程 2 执行。

stderr:
PS C:\Users\mingm\Desktop\test>
```
node.js的执行为异步执行，导致先循环3次，每次提交。
所以输出i的值全为3
由于先运行子进程，子进程执行完毕以后，触发exit事件，
执行
```
        console.log('子进程已退出，退出码 '+code);
        console.log('执行顺序' + count++);
```
该两句。
接着执行
```
        console.log('---------------------');
        console.log(i);
        console.log('stdout: ' + std);
        console.log('stderr: ' + stderr);
```
执行完毕。
node最大的特点是异步执行。
# spawn()方法
同样也是使用指定的命令行，创建新进程。
```
PS C:\Users\mingm\Desktop\test> node master.js
stdout进程 0 执行。

stdout进程 1 执行。

子进程退出0
stdout进程 2 执行。

子进程退出0
子进程退出0
PS C:\Users\mingm\Desktop\test> node master.js
stdout进程 0 执行。

子进程退出0
stdout进程 1 执行。

stdout进程 2 执行。

子进程退出0
子进程退出0
PS C:\Users\mingm\Desktop\test> node master.js
stdout进程 0 执行。

stdout进程 1 执行。

子进程退出0
stdout进程 2 执行。

子进程退出0
子进程退出0
PS C:\Users\mingm\Desktop\test>
```
node执行异步相当魔幻
飘忽不定
```
/*master.js*/
const fs = require('fs');
const child_process = require('child_process');

for(var i=0; i<3; i++) {
	var workerProcess = child_process.spawn('node', ['support.js', i]);

	// 绑定两个事件
	workerProcess.stdout.on('data', (data) => {
		console.log('stdout' + data);
	});

	workerProcess.stderr.on('data', (data) => {
		console.log('stderr', + data);
	});

	// 设置退出事件
	workerProcess.on('close', (code) => {
		console.log('子进程退出' + code);
	});
};
```
```
/*support.js*/
console.log("进程 " + process.argv[2] + " 执行。" );
```
和exec()的区别在于exec()是直接回调函数，而spawn()是直接绑定事件
# fork()方法
```
PS C:\Users\mingm\Desktop\test> node master.js
进程 0 执行。
进程 1 执行。
进程 2 执行。
子进程已经退出0
子进程已经退出0
子进程已经退出0
PS C:\Users\mingm\Desktop\test>
```
```
const fs = require('fs');
const child_process = require('child_process');

for(var i=0; i<3; i++) {
	var worker_process = child_process.fork('support.js', [i]);

	worker_process.on('close', (code) => {
		console.log('子进程已经退出' + code);
	});
}
```
还是喜欢fork方法。fork很方便。没有那么多的异步让人头疼。