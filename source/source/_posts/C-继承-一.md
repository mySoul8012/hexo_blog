title: C++ 继承 一
author: Ming ming
date: 2018-10-22 02:14:52
tags:
---
C++ 继承
面向对象最重要的是继承，继承允许依据一个类定义另一个类。
> 特点重用代码功能，提高执行时间。

# 基类 派生类
基类，以有的类称为基类。
派生类，根据基类派生出的类称为派生类。
```
#include <iostream>

using namespace std;

// 创建基类
class Shape {
public:
	void setWidth(int w){
		width = w;
	}
	void setHeight(int h){
		height = h;
	}
protected:// 成员访问控制，为保护性继承，外部的类无法访问，只有同一类和派生类才能访问。
	int width;
	int height;	
};

// 派生类
class Rectangle: public Shape{	// 基于公有基类，继承，基类的公有成员为派生类的公有成员，基类的保护成员为派生类的保护成员，基类的私有成员不能直接被派生类访问，但是可以通过调用基类的公有和保护成员访问。
public:
	int getArea(){
		return (width * height);
	}
};

int main(void){
	Rectangle Rect;	// 创建一个对象,该对象拥有派生类和基类两个的属性和方法

	Rect.setWidth(5);
	Rect.setHeight(7);

	// 输出对象的面积
	cout << "Total area;" << Rect.getArea() << endl;

	return 0;
}
```

# 访问控制和继承
派生类可以访问基类中的非私有成员。
一个派生类，继承了基类的所有方法。
下列的除外
1. 基类的构造函数，析构函数，拷贝构造函数，此时都不能被基类继承。
2. 基类的重载运算符（下面的内容）。
3. 基类的友元函数。

# 继承类型
公有继承，类派生自公有基类时，基类的公有成员为派生类的公有成员。基类的保护成员为派生类的保护成员。基类的私有不能被派生类访问，通过基类的公有和保护成员访问。

保护继承，一个类派生自保护基类时，基类的公有和保护成员将成为派生类的保护成员。

私有继承，一个类派生自私有基类时，基类的公有和保护成员，将成为派生类的私有成员。