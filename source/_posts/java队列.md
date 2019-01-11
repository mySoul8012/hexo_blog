title: java队列
author: Ming ming
tags: []
categories:
  - 基础知识
  - 数据结构
date: 2018-11-17 19:36:00
---
Java 实现队列
# 介绍
队列为特殊的线性表，队列的特点先进先出（FIFO），队列插入为入队，队列删除为出对。
# Java 实现
这次使用顺序队列实现。（使用数组），
why？为什么不直接使用顺序表作为底层容器，因为入队操作执行顺序表尾插入，时间复杂度为O(1)
> O(1) 普通语句，相互操作，时间复杂度为O(1)

出对操作执行表头删除操作，时间复杂度为O(n)，因为涉及到一个循环遍历，移动，由于时间复杂度高，此时直接想方法将时间复杂度降低为O(1) ，即，用双指针解决。即front和rear两个解决
> 时间复杂度 O(n) 涉及一层循环，此时时间复杂度为O(n)

又因为直接更改下标，会导致空间的浪费，（出队操作）此时，为了减少空间的浪费，将队列设计为循环队列，目的，避免假满现象的出现。

空队列的时候 front = rear = 0 
入队 front = 0 rear = 1
此时继续入队 front = 0 rear = 2
出队 front = rear = 2 两者相等
继续入队，front=2 rear = 3
不断的循环，总有一个为空，即rear
到队满 即 front = 2 rear = 1；
队满的判断  front = （rear + 1）% size 
real永远为空
# 代码
## 接口
```
package demo.mingm.struct.queue;

/**
 * 接口 队列
* @author ming
* @date 2018/11/17
*/
public interface Queue<T> {
	// 定义数组长度
	public static final int DEFAULT_SIZE = 10;
	// 返回队列长度
	int size();
	// 判断队列是否为空
	boolean isEmpty();
	// 判断队列是否已满
	boolean isFull();
	// 入队， 成功true 错误false
	boolean add(T data);
	// offer 入队，和add方法不同的是，如果队满，或传入的为空，将会抛出错误，不会自动扩充
	boolean offer(T data);
	// 返回队头元素，不执行删除操作，为空 返回null
	T peek();
	// 返回队头元素，如果为空，将会抛出异常
	T element();
	// 出队，执行删除操作，若为空，返回null
	T poll();
	// 出队，执行删除操作，若为空，抛出异常
	T remove();
	// 清空队列
	void cleameQueue();
	
}
```
## 实现接口的类
```
package demo.mingm.struct.queue;
import java.util.Arrays;
import java.util.Vector;
public class SeqQueue<T> implements Queue<T> {
	private T[] elementData;	// 储存数据的数组
	private int size;	// 储存大小
	private int front, rear;	// 指针指向数组的元素，一个前，一个后
	private int real;
	
	public SeqQueue() {
		elementData= (T[]) new Object[DEFAULT_SIZE];
		// 指针的初始化
		this.front = 0;
		this.rear = 0;
		this.size = 0;
	}
	
	public SeqQueue(int length) {
		elementData = (T[]) new Object[length];
		this.front = 0;
		this.rear = 0;
		this.size = 0;
	}
	
	public int getSize() {
		return this.size;
	}
	
	public int getFront() {
		return this.front;
	}
	
	public int getRear() {
		return this.rear;
	}
	
	public void setSize(int size) {
		this.size = size;
	}
	
	public void setFront(int front) {
		this.front = front;
	}
	
	public void setRear(int rear) {
		this.rear = rear;
	}
	
	// 获取队列长度
	@Override
	public int size() {
		return this.getSize();
	}

	// 判断队列是否为空
	@Override
	public boolean isEmpty() {
		return this.getRear() == this.getFront();
	}
	
	// 判断队列是否已满
	@Override
	public boolean isFull() {
		return this.getFront() == (this.getRear() + 1) % this.elementData.length;
	}
	
	// 入队操作，如果不满，自动扩充数组
	@Override
	public boolean add(T data) {
		if(this.isFull()) {
			Arrays.copyOf(elementData, elementData.length*2);
		}
		// 是否插入空
		if(data == null)
			return false;
		// 添加data
		elementData[this.getRear()] = data;
		// 移动指针
		this.rear++;	// 创造单向队列
		this.size++;
		return true;
	}

	@Override
	public boolean offer(T data) {
		if(this.isFull() || data == null) {
			throw new NullPointerException("error 1");
		}
		// 添加data
		this.elementData[this.getRear()] = data;
		// 移动指针
		this.real = (this.real + 1)%elementData.length;	// 创造循环队列
		this.size++;
		return true;
	}

	// 返回队头元素，不删除
	@Override
	public T peek() {
		if(this.isEmpty())
			return null;
		return this.elementData[this.getFront()];
	}

	// 返回队头元素
	@Override
	public T element() {
		if(this.isEmpty())
			throw  new NullPointerException("error 2");
		return this.elementData[this.getFront()];
	}

	// 出队
	@Override
	public T poll() {
		if (this.isEmpty())
			return null;
		T tmp = this.peek();
		// 循环队列
		this.front = (this.getFront() + 1 ) % this.elementData.length;
		return tmp;
	}

	// 出队
	@Override
	public T remove() {
		if (this.isEmpty())
			throw  new NullPointerException("error 3");
		T tmp = this.peek();
		// 循环队列
		this.front = (this.getFront() + 1 ) % this.elementData.length;
		return tmp;
	}

	// 清空
	@Override
	public void cleameQueue() {
		this.real = 0;
		this.front = 0;
	}
}

```
www.iming.info