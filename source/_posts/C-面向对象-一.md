title: C++ 面向对象 一
author: Ming ming
tags: []
categories:
  - 基础知识
  - C++
date: 2018-10-20 05:49:00
---
C++ 面向对象
> c++创建对象的时候如果使用new运算符，将会返回返回一个指针，指向堆中的内存地址


# 类，对象
## 类定义
定义一个类，用来描述一个盒子
```
#include <iostream>

using namespace std;

class Box {
	public: double length;	// 定义长度
			double breadth;	// 定义宽度
			double height;	// 定义高度
};

int main(){
	return 0;
}
```
public 表明这是一个公共的成员。class定义一个类

## 定义对象
```
#include <iostream>

using namespace std;

class Box {
	public: double length;	// 定义长度
			double breadth;	// 定义宽度
			double height;	// 定义高度
};

int main(){
	Box box1;	// 声明一个对象
	Box box2； // 声明一个对象

	return 0;
}
```
```
#include <iostream>

using namespace std;

class Box {
	public: double length;	// 定义长度
			double breadth;	// 定义宽度
			double height;	// 定义高度
};

int main(){
	Box box1;	// 声明一个对象
	Box box2； // 声明一个对象
	double volume = 0.0;	// 定义一个储存体积的

	// 第一个盒子
	box1.length = 5.0;
	box1.breadth = 7.0;	
	box1.height = 5.0;

	// 第二个盒子
	box2.length = 10.0;
	box2.breadth = 10.0;
	box2.height = 10.0;

	// 第一个盒子的体积
	volume = box1.length * box1.breadth * box1.height;
	cout << "第一个盒子的体积" << volume << endl;

	// 第二个盒子的体积
	volume = box2.length * box2.breadth * box2.height;
	cout << "第二个盒子的体积" << volume << endl;

	return 0;
}
```
## 类和函数成员
类可以为函数成员。
```
#include <iostream>

using namespace std;

int getVolume(void){
	return 3;
}

class Box {
	public: double length;	// 定义长度
			double breadth;	// 定义宽度
			double height;	// 定义高度
			double getVolume(void);	// 调用函数，将会返回体积。
};

int main(){
	
	return 0;
}
```
```
#include <iostream>

using namespace std;

class Box {
	public: double length;	// 定义长度
			double breadth;	// 定义宽度
			double height;	// 定义高度
			double getVolume(void){
				return length * breadth * height;
			}
};

int main(){
	
	return 0;
}
```

## 范围解析运算符
访问解析运算符为:: 说明函数属于哪个类
范围解析运算符指明函数属于哪个类，标明作用域。
```
#include <iostream>

using namespace std;

int year;	// 定义一个全局变量

class Box {
	public: double length;	// 定义长度
			double breadth;	// 定义宽度
			double height;	// 定义高度
			double getVolume(void){
				return length * breadth * height;
			}
};

void setYear(int year){
	::year = year;	// 指向全局变量
}

int main(){
	
	return 0;
}
```
在类的外部标明类的成员
```
#include <iostream>

using namespace std;

int year;	// 定义一个全局变量

class Box {
	public: double length;	// 定义长度
			double breadth;	// 定义宽度
			double height;	// 定义高度
			double getVolume(void){
				return length * breadth * height;
			}
};

void setYear(int year){
	::year = year;	// 指向全局变量
}

double Box::getLength(void){
	return length;	// 此处返回的是Box类下的getLength变量
}

int main(){
	
	return 0;
}
```
## 关于inline
解决小函数频繁入栈，出栈的问题，引入inline关键字。
即，内联函数。
使用内联函数的时候，编译器会进行自动替换，即类似于C语言中的宏。以减少入栈和出栈的操作。

> 这是建议，是否取决于编译器

使用inline的时候，建议在h文件中，需要的时候写inline
https://openhome.cc/Gossip/CppGossip/inlineFunction.html

## 关于虚函数
虚函数，用来实现多重继承和多态。
这个后期在说

## 类访问修饰符
数据的封装为面向对象的特点。
防止函数直接访问类的内部成员。
作用域为一个大花括号
### public成员
public在外部可以访问
```
#include <iostream>

using namespace std;

class Line{
public:
	double length;
	void setLength(double len);	// 设置length
	double getLength(void);	// 获取length
}

// 对成员函数进行定义
double Line::getLength(void){
	return length;
}

void Line::setLength(double len){
	length = len;
}

// 主函数
int main(){
	Line line;

	// 设置长度
	line.setLength(6.0);
	cout << line.getLength() << endl;

	// 设置长度
	line.length = 10.0;
	cout << line.length << endl;

	return 0;
}
```
### private 成员
即私有成员，在外部无法访问
> 缺省值为private 私有的

### protected 保护成员
和私有成员类似，最大的不同在于在子类中仍然可以访问。

## 构造函数 析构函数
### 构造函数
创建对象的时候会执行构造函数
```
#include <iostream>

using namespace std;

class Line{
public:
	void setLength(double len);
	double getLength(void);
	Line();	// 构造函数

private:	// 私有
	double length;
};

// 成员函数定义
Line::Line(void)
{
    cout << "Object is being created" << endl;
}

void Line::setLength(double len){
	length = len;
}

double Line::getLength(void){
	return length;
}

// 程序主函数
int main(){
	Line line;

	// 设置长度
	line.setLength(6.0);
	cout << line.getLength() << endl;

	return 0;
}
```
### 析构函数
类的特殊成员函数，每次删除创建的对象将会执行析构函数
> java中是直接将指向设置为null，即可自动进行清除

```
#include <iostream>

using namespace std;

class Line{
public:
	void setLength(double len);
	double getLength(void);
	Line();	// 构造函数
	~Line();	// 析构函数

private:	// 私有
	double length;
};

// 成员函数定义
Line::Line(void)
{
    cout << "Object is being created" << endl;
}

Line::~Line(){
	cout << "Object is being deleted" << endl;
}

void Line::setLength(double len){
	length = len;
}

double Line::getLength(void){
	return length;
}

// 程序主函数
int main(){
	Line* line = new Line();

	// 设置长度
	line->setLength(6.0);
	cout << line->getLength() << endl;

	delete line;

	return 0;
}
```

### 构造函数初始化列表
```
#include <iostream>

using namespace std;

class Line{
public:
	void setLength(double len);
	double getLength(void);
	Line();	// 构造函数
	~Line();	// 析构函数

private:	// 私有
	double length;
};

// 成员函数定义
Line::Line(void):length(3)	// 等价于内部定义 length = 3
{
    cout << "Object is being created" << endl;
}

Line::~Line(){
	cout << "Object is being deleted" << endl;
}

void Line::setLength(double len){
	length = len;
}

double Line::getLength(void){
	return length;
}

// 程序主函数
int main(){
	Line* line = new Line();

	// 设置长度
	line->setLength(6.0);
	cout << line->getLength() << endl;

	delete line;

	return 0;
}
```
需要注意的是，声明的时候是按照声明的顺序进行初始化的，而不是根据初始化列表进行初始化的

## 拷贝构造函数
一种特殊的构造函数。
> 这里会涉及到深拷贝和浅拷贝的问题，深拷贝开辟空间，浅拷贝进行引用

使用的场景
把对象传入函数
将对象返回函数
深拷贝，浅拷贝，即使用同类型的对象初始化一个新的对象

> 类中有指针变量，动态内存分配的时候，必须设置一个拷贝构造函数，如果没有编译器会自动生成拷贝构造函数

```
#include <iostream>

using namespace std;

class Line{
public:
	int getLength(void);
	void setLength(int length);
	Line(int len);
	Line(const Line &obj);	// 拷贝构造函数 传入的是地址
	~Line();

private:
	int* ptr;	// 定义一个空指针
};

// 设置成员函数，以及构造函数
Line::Line(int len){
	cout << "调用构造函数" << endl;
	// 进行内存分配
	ptr = new int;	// 在堆中创建内存空间，完成指向
	*ptr = len;	// 将传入的内容进行复制到新开辟在堆中的内存空间
}

Line::Line(const Line &obj){
	cout << "调用拷贝构造函数并为指针ptr分配内存，即完成深拷贝" << endl;
	ptr = new int;	// 重新开辟出一块新的内存空间，完成深拷贝
	*ptr = *obj.ptr;	// 将待拷贝的，进行内容的赋值
}

Line::~Line(void){	// 析构函数
	cout << "释放内存" << endl;
	delete ptr;	// 将指针删除，此时在堆中的一并删除
}
int Line::getLength(void){
	return *ptr;	// 返回指向堆中int的内容
}
void Line::setLength(int length){
	*ptr = length;
}

void display(Line obj){	// 传入一个对象	创建了一个副本，此时有两份内存。同时储存着obj
	cout << "line 大小:" << obj.getLength() << endl;
	// 进行赋值
	obj.setLength(3);
	cout << "line 大小:" << obj.getLength() << endl;
}
// 主函数
int main(){
	// 进行拷贝初始化
	Line line1(10);
	//Line line3 = line1;

	Line line2 = line1;	// 调用拷贝构造函数，创建了一块新的空间

	display(line1);
	display(line2);

	cout << line1.getLength() << endl;

	line1.setLength(4);
	cout << line1.getLength() << endl;
	return 0;
}
```

## 友元函数
友元函数定义在外部，但是有权访问内部成员。
需要在原型中使用friend关键字
```
#include <iostream>

using namespace std;

class Box{
    double width;	// 缺省值为私有的
public:
    friend void printWidth(Box box);	// 定义友元函数,友元函数没有this指针
    void setWidth(double wid);
};

// 成员函数定义
void Box::setWidth(double wid){
    width = wid;
}

// 友元函数不是任何类的成员函数
void printWidth(Box box){
    // 友元函数可以访问类中的任何成员
    cout << "width of box" << box.width << endl;
}

int main(){
    Box* box = new Box();

    // 使用成员函数设置宽度
    box -> setWidth(10.0);

    // 使用友元函数输出宽度
    printWidth(*box);

    return 0;
}
```

## this指针
每一个对象可以通过this指针访问自己的地址。
```
#include <iostream>

using namespace std;

class Box{
public:
    // 构造函数定义
    Box(double l = 2.0, double b = 2.0, double h = 2.0){
        cout << "开始输出值" << endl;
        length = 1;
        breadth = b;
        height = h;
    }
    double Volume(){
        return length * breadth * height;
    }
    int compare(Box box){
        return this -> Volume() > box.Volume();	// this指向调用的对象，返回一个布尔值
    }
private:
    double length;
    double breadth;
    double height;
};

int main(void){
    Box Box1(3.3, 1.2, 1.5);
    Box Box2(8.5, 6.0, 2.0);

    cout << Box1.compare(Box2) << endl;

    return 0;
}
```
## 类的静态成员
使用static关键字
常用于定义工具函数
静态成员函数，没有this指针，只能访问静态成员。
普通成员有this指针，可以访问类中的任意成员，静态成员函数没有this指针。
初始化使用
```

int Box::objectCount = 0;
```
至于为什么要在外面定义，因为要进行分配内存空间。
而类仅仅是定义。
