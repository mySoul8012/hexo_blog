title: java 多线程
author: Ming ming
tags: []
categories:
  - 后端
  - Java
  - ''
date: 2018-11-16 17:18:00
---
java多线程
# 关于内存
每个线程会有自己的线程栈，即，变量不能共享，只能传值拷贝
每个线程new出的对象全都保存在堆中，全部共享
# 线程的生命周期
线程具有5种状态，即新建，就绪，运行，阻塞，死亡。
新建，当new出来一个线程以后，jvm为其分配内存空间，并初始化成员变量的值
就绪，当线程调用了strat()方法的时候，线程就绪，会为其创建方法调用栈和程序计数器。
> 方法调用栈 即，记录方法调用的次数
> 程序计数器 存放下一条单元指令的地方

运行；就绪状态获得cpu，开始执行run()方法
阻塞：例如进入I/O操作
## 新建，就绪
使用new关键字创建一个线程以后，该线程处于新建状态，和其他java线程一样，仅仅由java虚拟机为其分配内存，初始化变量成员的值。
## 运行和阻塞
### 线程调度
桌面和服务器使用抢占式调度策略，小型设备使用协作式调度策略，
### 线程阻塞
线程使用sleep()方法主动放弃所占用的处理器资源。
线程调用阻塞式I/O方法，方法被返回前，阻塞
线程等待通知
线程调用suspend()挂起
### 解除阻塞
依依对应即可
# 线程优先级
普通5，低1，高10
默认是5
# 关于start和run
start创建一个线程，由于是时间片运行的，所以需要run方法进行运行。
总结
start创建线程，run方法运行线程。
# 创建线程
## 使用Thread继承类实现创建线程
文档 https://docs.oracle.com/javase/8/docs/api/
该类必须重写run方法。为新线程的入口点。
必须调用start()方法才能运行。
> 本质上是Runnable接口的一种实现

```
package demo2;

public class test {
	public static void main(String[] args) {
		// 创建一个线程
		ThreadDemo run1 = new ThreadDemo();
		run1.start();// 启动线程
		// 在运行线程以后，会不定时的jvm调用run方法，进行运行
	}
}
```
```
package demo2;

public class ThreadDemo extends Thread{
	public ThreadDemo() {
		System.out.println("hello world");
	}
	
	public void run() {
		System.out.println("线程进入");
		for(int i = 0; i > 10; i++) {
			System.out.println("输出内容");
		}
		System.out.println("线程执行完毕");
	}
}

```
事实上父类的start方法也可以重写
```
package demo2;

public class ThreadDemo extends Thread{
	public ThreadDemo() {
		System.out.println("hello world");
	}
	
	public void run() {
		System.out.println("线程进入");
		for(int i = 0; i > 10; i++) {
			System.out.println("输出内容");
		}
		System.out.println("线程执行完毕");
	}
	
	public void start() {
		System.out.println("启动线程");
		this.run();
	}
}
```
然后测试类
```
package demo2;

public class test {
	public static void main(String[] args) {
		// 创建一个线程
		ThreadDemo run1 = new ThreadDemo();
		run1.start();// 启动线程
	}
}
```
### Thread方法
#### public final void setDaemon(boolean on)
用于标记守护线程和用户线程
用户线程，平常创建的普通线程
守护线程，服务于用户线程，不需要上层调用，例如gc垃圾回收为一个明显的守护线程，mysql中也有执行定时任务的线程。
#### 中断线程
它表示一个线程被中断，会抛出错误。

## 使用Runnable接口
文档https://docs.oracle.com/javase/8/docs/api/
属于java.lang包内的，为自动默认加载的
该接口具有一个run方法，run方法为程序的入口
必须通过Thread类的构造方法实现启动线程
```
package demo2;

public class test {
	public static void main(String[] args) {
		// 创建一个线程
		demoRunnable r1 = new demoRunnable();
		// 使用Thread类的构造方法传入线程，并起名，然后运行
		new Thread(r1, "name").start();// 创建完成线程以后，调用start启动线程
	}
}
```
```
package demo2;

public class demoRunnable implements Runnable{
	private int i;

	// 下方的为运行的线程
	@Override
	public void run() {
		for(int i = 0; i < 100; i++) {
			System.out.println("运行线程 " + i);
		}
	}
}
```
## 通过Callable和Future来创建线程
使用Callable创建接口的实现类
接口源码如下
```
@FunctionalInterface
public interface Callable<V> {
    V call() throws Exception;
}
```
实现了一个泛型，该并且返回该类型，需要实现call方法。使用包装对象

> 关于包装类型，即，将不是对象的内容包装成为对象，为包装类型，实现了对象的类型，为一个类

先实现Callable接口，其中的call类为程序的子线程的执行体
```
package demo2;

import java.util.concurrent.Callable;

public class CallableDemo implements Callable<Integer>{
	@Override
	public Integer call() throws Exception {
		System.out.println("开始运行一个线程");
		for(int i = 1, i < 10; i++) {
			System.out.println("运行中");
		}
		// 阻塞该线程
		Thread.sleep(200);
		return 1;	// 返回线程的值
	}
}
```

接着创建Future对象，将用于启动子线程
```
package demo2;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

public class test {
	public static void main(String[] args) {
		// 先创建实例
		CallableDemo ctt = new CallableDemo();
		FutureTask<Integer> ft = new FutureTask<>(ctt);	// 该方法为了获取返回值而设定	
		new Thread(ft, "返回结果的值").start();
		try {
			System.out.println(ft.get());
		} catch (InterruptedException | ExecutionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
```
```
package demo2;

import java.util.concurrent.Callable;
import java.util.concurrent.FutureTask;

public class CallableDemo implements Callable<Integer>{
	@Override
	public Integer call() throws Exception {
		System.out.println("开始运行一个线程");
		for(int i = 1; i < 10; i++) {
			System.out.println("运行中");
		}
		return 1;	// 返回线程的值
	}
}
```
