title: java 生产者-消费者问题
author: Ming ming
tags: []
categories:
  - 基础知识
  - 操作系统
date: 2018-11-18 16:22:00
---
java 生产者-消费者问题

# 前
直接一张大图
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/11/17/2.png)

# 使用wait和notify方法实现
## 等待通知机制
即，一个线程A调用对象O的wait()方法，进入等待状态，另一个线程调用对象O的notify()/notifyAll() 方法，线程A收到通知退出等待，进入可运行状态。
方法名称 | 描述
-----------|------
notify() | 通知等待队列中的一个线程，进入可运行队列，等待时间片轮转到该线程，进行运行
notifyAll() | 同上，但是通知所有
wait() | 释放共享资源锁，从运行退出，进入等待队列
wait(long) | 超时等待一段时间
wait(long int) | 对超时的更细致的控制

## 锁
synchronized 对一段代码进行加同步锁操作。
> 同步锁 每次运行该加锁的代码段，进入竞争机制，每次只能有一个进程运行该代码，线程之间并发运行
> 异步锁 多个线程有互斥操作，只有一个结束以后才能运行另外一个，线程之间相互互斥

## 消费者和生产者
```
package demo1;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Test {
		Integer count = 0;	// 计数
		String LOCK = "lock";	// 锁
		static final int FIFE = 10;
		
		public static void main(String[] args) {
			ExecutorService service = Executors.newFixedThreadPool(100);
			Test c = new Test();
			Producer producer = c.new Producer();
			Consumer consumer = c.new Consumer();
			for(int i = 0; i < 100; i++) {
				service.submit(producer);
				service.submit(consumer);
			}

		}
		
		class Producer implements Runnable{

			@Override
			public void run() {
				for(int i = 0; i < 10; i++) {
					try {
						Thread.sleep(4000);	// 进行线程阻塞
					}catch(Exception e) {
						e.printStackTrace();
					}
					
					// 下方为同步代码块,使用同步锁
					synchronized(LOCK) {
						// 进行生产产品
						if(count == FIFE) {
							// 商品生产满了
							try {
								LOCK.wait();
							} catch (InterruptedException e) {
								e.printStackTrace();
							}// 进入等待队列
						}
						count++;	// 商品数增加
						System.out.println(Thread.currentThread().getName() + "生产者目前有" + count);
						LOCK.notifyAll();	// 通知下一段进行运行，因为同一时刻，一个同步代码段，只能被一个线程运行，此时，执行到末尾，通知，下一个线程运行
					}
					// 下方代码是并发运行					
				}
				
			}
			
		}
	class Consumer implements Runnable{

		@Override
		public void run() {
			for(int i = 0; i< 10; i++) {
				try {
					Thread.sleep(5000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				synchronized(LOCK) {
					if(count == 0) {
						// 生产以满 进入等待
						try {
							LOCK.wait();
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					}
					// 进行消费
					count--;
					System.out.println(Thread.currentThread().getName() + "消费者目前有" + count);
					// 释放当前资源
					LOCK.notifyAll();
				}
				
			}	
			
		}
		
	}
		
		
	}


```
执行的时候由于是多个对多个容易导致假死的发生，这一点是需要注意的。由于由于竞争相互等待出现全部线程的相互等待，造成死锁的发生。

# 使用阻塞队列实现
使用阻塞队列实现
生产者往队列中放入生产者，消费者从队列中拿生产的产品，对队列需要加锁，每次只能有一个线程对队列进行操作
如果队列为空，或为满的时候，将会告知该线程等待操作，进入等待队列，
```
package demo2;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Test1 {
		Integer count = 0;	// 计数
		String LOCK = "lock";	// 锁
		static final int FIFE = 10;
		// 创建阻塞队列
		final BlockingQueue<Object> blockingQueue = new ArrayBlockingQueue<>(10);
		public static void main(String[] args) {
			ExecutorService service = Executors.newFixedThreadPool(100);
			Test1 c = new Test1();
			Producer producer = c.new Producer();
			Consumer consumer = c.new Consumer();
				service.submit(producer);
				service.submit(consumer);

		}
		
		class Producer implements Runnable {

			@Override
			public void run() {
				for(int i = 0; i < 10; i++) {
					try {
						Thread.sleep(4000);	// 进行线程阻塞
					}catch(Exception e) {
						e.printStackTrace();
					}
						try {
							blockingQueue.put(1);
						} catch (InterruptedException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}	// 提交到阻塞队列中的生产的产品
						count++;	// 商品数增加
						System.out.println(Thread.currentThread().getName() + "生产者目前有" + count);
				}
					// 下方代码是并发运行					
				}
				
			}
	class Consumer implements Runnable{

		@Override
		public void run() {
			for(int i = 0; i< 10; i++) {
				try {
					Thread.sleep(5000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
					try {
						blockingQueue.take();
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					count--;
					System.out.println(Thread.currentThread().getName() + "消费者目前有" + count);
				}
				
			}	
			
		}
		
	}

```
死锁不存在，忘记设置死循环了。。