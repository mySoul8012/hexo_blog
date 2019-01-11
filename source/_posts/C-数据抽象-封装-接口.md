title: C++ 数据抽象  封装 接口
author: Ming ming
tags: []
categories:
  - 基础知识
  - C++
date: 2018-11-06 14:22:00
---
# C++ 数据抽象
## 什么是数据抽象
向外界提供关键信息。隐藏其后台的实现细节。只表现必要的信息，不呈现细节。
数据抽象是依赖于接口和实现分离。
> 通过外部接口，对其内部进行实现。达到数据抽象的目的

```
#include <iostream>
using namespace std;

int main(){
	cout << "hello c++" << endl;
	return 0;
}
```
在上方中，不需要理解cout如何在屏幕上输出内容，只需要知道这是一个接口，用于定义进行输出。

## 优势
类的内部受到保护，不会因为用户错误对对象导致受到损害。
类的实现可能会受到时间的推移而发生变化，应对不断变化的需求，只需要更改类即可，不用更改业务代码，完成分离

## 数据抽象的实例
```
#include <iostream>
using namespace std;

class Adder{
public:
	// 构造函数
	Adder(int i = 0){
		total = i;
	}
	// 对外的接口
	void addNum(int number){
		total += number;
	}
	// 对外的接口
	int getTotal(){
		return total;
	}
private:
	// 对外隐藏的数据
	int total;
}

int main(){
	Adder* a = new Adder();

	a.addNum(30);
	a.addNum(20);
	a.addNum(30);

	cout << "Total" << a.getTotal() << endl;
	return 0;
}
```
## 设计
抽象把代码分离为接口和实现。
设计组件的时候，必须保持接口的独立实现。无论怎么改变底层，接口也将保持不变。
# 数据抽象
程序语句 程序中执行动作的部分称为函数
程序数据 数据为程序的信息，会受到函数的影响。
## 数据隐藏
数据隐藏属于OOP中的封装的特性。
> OOP中的三大特性，封装，继承，多态，封装，提供set和get方法，用于进行封装，即对内保护，对外隐藏。继承java中使用的是extends，进行继承，有单一继承和多重继承。多态、定义一个接口，即抽象类，用来对于某些规则进行定义，实现对于不同的处理进行不同的反馈，得到多态。

数据封装为public和private等
```
#include <iostream>

int main(){
	class Box{
	public:
		double getVolume(void){
			return length * breadth * height;
		}
	private:
		double length;	// 长度
		double breadth; // 宽度
		double height;	// 高度
	}
}
```
在上方中，封装数据，并对外提供接口为getVolme，并且private保证了对数据的保护，防止非法操作，并且将数据和实现分离，确保当业务代码更改的时候，数据也可以进行更改。

## 设计
设计类的成员为私有，除非真的要对齐暴露，确保封装性。
包括对于虚函数来说，也是如此。
# 接口
C++的接口，使用虚函数进行实现。通过= 0 说明该虚函数为没有方法体，虚函数需要在派生类中进行具体的实现。
## 设计
封装的作用是用来保护代码，继承是用来增强代码的复用，多态是用来派生类的功能可以被基类所调用，并且可以对类进行进一步的抽象达到更高的复用的目的。
接口的作用，用于统一规范代码，用于对各个模块提供一个统一的接口用于进行实现。
多态和接口
接口是多态的实现的一种方式。


![upload successful](/images/pasted-28.png)
