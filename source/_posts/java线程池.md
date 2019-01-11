title: java线程池
author: Ming ming
tags: []
categories:
  - 后端
  - Java
date: 2018-11-17 11:34:00
---
java 线程池
# 前言
java创建线程不能显式的创建线程，应当使用线程池创建
> 原因，减少创建和销毁线程上花的时间，以及系统资源消耗。

## why？
使用面向对象的思维，事先创建了大量的线程，然后每个线程为一个对象，只需要直接拿来用即可，减少了创建线程，销毁线程对系统资源的消耗。

所以，使用线程池能减少耗费
> nginx中也提供了thread_pool模块，达到短时间内创建大量的线程

# 使用线程池创建线程
使用的是静态类的内容
文档 https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/Executors.html
> 使用的是工厂模式

使用的是Executors类提供的静态方法创建
内容如下
Executors.newCachedThreadPool()：无限线程池。
Executors.newFixedThreadPool(nThreads)：创建固定大小的线程池。
Executors.newSingleThreadExecutor()：创建单个线程的线程池。

# 大致的实现过程
大致的，一个流程图说明。
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/11/17/0.png)
具体的有点似懂非懂
在java doc中推荐使用Executors类的静态方法创建线程池

# 一个栗子
```
package demo;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Test {
	public static void main(String[] args) {
		 // 创建线程池 即创建有5个线程的线程池
		ExecutorService service =Executors.newFixedThreadPool(5);
		Demo1 c = new Demo1();
		// 获取线程中的对象
		service.submit(c);
		service.submit(c);
		service.submit(c);
		// 关闭线程池
		service.shutdown();
	}
}
```
```
package demo;

import java.util.concurrent.Callable;

public class Demo1 implements Callable<Object>{

	@Override
	public Object call() throws Exception {
		for(int i = 0; i < 10; i++) {
			System.out.println("正在运行" + i);
		}
		return null;
	}

}
```
上面中使用线程池，获取了两个线程，两个线程在同一个cpu上交替运行，所以每次运行的结果也不相同，线程运行的实现了Callable的接口。

# 提供的三个静态方法
```
Executors.newCachedThreadPool();        //创建一个缓冲池，缓冲池容量大小为Integer.MAX_VALUE
Executors.newSingleThreadExecutor();   //创建容量为1的缓冲池
Executors.newFixedThreadPool(int);    //创建固定容量大小的缓冲池
```
> Integer为包装类型

# 如何配置线程池大小
cpu密集任务，分配较少的线程，尽可能的压榨cpu
I/O密集的任务，尽可能的多配置线程，cpu个数*2

# Spring Boot
不会 
入门 https://www.ibm.com/developerworks/cn/java/j-spring-boot-basics-perry/index.html

# 线程池隔离
目的，是为了防止一个业务将所有的内存空间压榨完，导致崩溃，所以每个业务的线程池应当隔离运行
例如，下单任务用一个线程池，获取数据任务用一个线程池，其中任何一个出现问题，都不会把线程池耗费完全。确保应用依旧能正常的运行。

## hystrix 隔离
使用hystrix 框架进行隔离
GitHub https://github.com/Netflix/Hystrix
了解。不会用。