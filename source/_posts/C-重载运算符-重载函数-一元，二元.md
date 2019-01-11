title: C++重载运算符 重载函数 一元，二元
author: Ming ming
tags: []
categories:
  - 基础知识
  - C++
date: 2018-10-26 00:50:00
---
C++重载运算符 重载函数 一元，二元
# C++ 函数重载
```
// main.c
#include "pch.h"
#include <iostream>
using namespace std;


int main()
{
	printData* p_data = new printData();
	
	cout << p_data->print(2) << endl;

	char text[] = "hello world";
	cout << p_data->print(text) << endl;

	cout << p_data->print(3.14) << endl;


	return 0;
}
```
```
#include "pch.h"
printData::printData(void) {

};

int printData::print(int i) {
	return i;
};

double printData::print(double i) {
	return i;
}

char* printData::print(char c[]) {
	return c;
}
```
```
// pch.h
class printData {
public:
	printData();
	int print(int i);
	double print(double i);
	char* print(char c[]);
};
```

# C++ 运算符重载
即使用函数重新定义运算符
用来实现对对象的加减乘除的运算
## 一元运算符重载
一元运算符，对一个操作数操作，例如++，--，一元减运算符，逻辑非运算符
```
// pch.h
class Distance {
private:
	int feet;	// 0 到无穷
	int inches;	// 0 到 12
public:
	// 构造函数
	Distance();
	Distance(int f, int i);
	// 距离方法
	int displayDistance();
	// 重载- 运算符
	Distance operator-();

};

```
```
// pch.cpp
#include "pch.h"

Distance::Distance() {
	feet = 0;
	inches = 0;
}

Distance::Distance(int f, int i) {
	feet = f;
	inches = i;
}

int Distance::displayDistance() {
	return feet + inches;
}

Distance Distance::operator-() {
	feet = -feet;
	inches = -inches;
	return Distance(feet, inches);
}
```
```
// main.cpp
#include "pch.h"
#include <iostream>
using namespace std;


int main()
{
	Distance* D1 = new Distance(11, 10);
	Distance* D2 = new Distance(-5, 11);

	-(*D1);	// 使用重载运算符
	cout << D1->displayDistance() << endl;
	
	-(*D2);
	cout << D2->displayDistance() << endl;

	return 0;
}
```

## 二元运算符重载
```
// main.cpp
#include "pch.h"
#include <iostream>
using namespace std;


int main()
{
	Box* box1 = new Box();
	Box* box2 = new Box();
	Box* box3 = new Box();
	double volume = 0.0;

	box1->setHeight(12.0);
	box1->setLength(10.2);

	box2->setHeight(12.3);
	box2->setLength(10.2);

	volume = box1->getVolume();
	cout << volume << endl;

	cout << box2->getVolume() << endl;

	*box3 = *box1 + *box2;
	cout << box3->getVolume() << endl;

	return 0;
}
```
```
// pch.cpp
#include "pch.h"

double Box::getVolume() {
	return length * height * breadth;
}

double Box::setLength(double len) {
	return length = len;
}

double Box::setHeight(double hei) {
	height = hei;
	return 1;
}

Box Box::operator+(const Box& b) {	// 创建引用
	Box tmpBox;	// 临时储存
	tmpBox.height = this->height + b.height;	// 将调用该函数的对象的height的值，和传入的对象的height的值合并
	tmpBox.breadth = this->breadth + b.breadth;
	tmpBox.length = this->length + b.length;
	return tmpBox;//返回该对象
}
```
```
// pch.h
class Box {
private:
	double length;
	double breadth;
	double height;
public:
	double getVolume(void);
	double setLength(double len);
	double setHeight(double hei);
	Box operator+(const Box& b);	// Box& 引用，为了防止内容误操作，使用const
};
```