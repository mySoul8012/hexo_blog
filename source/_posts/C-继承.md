title: C++ 继承
author: Ming ming
tags: []
categories:
  - 基础知识
  - C++
date: 2018-10-24 00:01:00
---
C++ 继承
创建一个类时，已有的类称为基类，新建的类称为派生类
# 基类 派生类
一个类可以派生自多个类，即从多个基类继承，获取函数。
```
#include <iostream>

using namespace std;

// 基类
class Shape {
public:
	void setWidth(int w){
		width = w;
	}
	void setHeight(int h){
		height = h;
	}
protected:
	int width;
	int height;
};

// 派生类
class Rectangle: public Shape {
public:
	int getArea(){
		return (width * height);
	}
};

int main(void){
	Rectangle Rect;

	Rect.setWidth(5);
	Rect.setHeight(7);

	// 输出对象的面积
	cout << "Total area:" << Rect.getArea() << endl;

	return 0;
}
```
一个派生类继承了所有的基类方法。
1. 基类的析构函数，构造函数，拷贝构造函数，将不会继承基类的方法
2. 基类的重载运算，下面的内容
3. 基类的友元函数

# 继承类型
公有继承，一个类派生自公有基类时，基类的公有成员为派生类的公有成员。基类的保护成员为派生类的保护成员，基类的私有成员，不能被派生类访问。可以调用基类的公有和保护成员访问。

保护继承，一个类派生自保护基类时，基类的公有和保护成员，将成为派生类的保护成员。

私有继承，一个类派生自私有基类时，基类的公有和保护，将成为派生类的私有成员

# 多继承
一个子类可以有多个父类，可以继承多个父类的特性。
```
#include <iostream>

using namespace std;

// 基类 Shape
class Shape {
public:
	void setWidth(int w){
		width = w;
	}
	void setHeight(int h){
		height = h;
	}
protected:
	int width;
	int height;
};

// 基类 PaintCost
class PainCost {
public:
	int getCost(int area){
		return area * 70;
	}
};

// 派生类
class Rectangle:public Shape, public PainCost{
public:
	int getArea(){
		return (width * width);
	}
};

int main(void){
	Rectangle Rect;
	int area;

	Rect.setWidth(5);
	Rect.setHeight(7);

	area = Rect.getArea();

	// 输出面积
	cout << "Total area" << Rect.getArea() << endl;

	// 输出花费
	cout << "花费" << Rect.getCost(area) << endl;

	return 0;
}

```
# 环状继承
出现如下的继承，即
C -> A and B
A -> D
B -> D
此时，形成环状的继承，如果创建C会有两条链，此时会产生两个D

解决方法，虚继承，用来确保只有一份基类拷贝在派生类对象中，防止出现重复。

格式
```
class 类名: virtual 继承方式 父类名
```
使用sizeof()进行判断
> 为什么会多出4字节，因为4个字节用于存放虚拟指针，存放虚指针，指向上一个类，而不是使用复制内存的方式。