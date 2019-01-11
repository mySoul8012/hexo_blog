title: 虚函数 C++
author: Ming ming
tags: []
categories:
  - 基础知识
  - C++
date: 2018-10-31 22:42:00
---
C++ 虚函数
# 虚函数
基类中使用virtual关键字声明的函数，称为虚函数。
虚函数的实现，通过虚函数表来实现的。即V-table 这个表中有一个类，用于储存虚函数的地址。解决其继承，覆盖的问题，用于保证其真实反映的函数。这样有虚函数的实例，将会储存在这个实例的内存中。即用父类的指针，操作子类的时候，通过虚函数表来实现找寻到父类。

定义下方的一个类
```
class Base{
public:
	virtual void f(){
		cout << "Base::f" << endl;
	}
	virtual void g(){
		cout << "Base::g" << endl;
	}
	virtual void h(){
		cout << "Base::h" << endl;
	}
}
```
然后通过实例化得到虚函数表
```
	Base* b = new Base();

	//Fun pFun = NULL;

	cout << "虚函数表地址 " << (int*)(&(*b)) << endl;	// 强制转换成为指针类型，然后输出
	cout << "虚函数表 - 第一个函数地址" << (int*)*(int*)(&(*b)) << endl;	// 取虚函数的地址，然后获得虚函数的头指向的第一个存储函数的内存空间。然后获取第一个函数的内存地址
```
然后查看输出的结果
```
虚函数表地址 0xb31268
虚函数表 - 第一个函数地址0x4c1490
```
根据地址可以看到，指针b指向创建的实例的地址，其首地址储存着虚函数表的地址，然后再次通过指针访问，得到虚函数表的第一个函数的指针的地址。
# 一般继承，没有虚函数覆盖
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/11.png)
在上方的继承中，子类没有重载任何父类的函数，那么在虚函数列表中，就代表着
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/12.png)

虚函数按照声明的顺序放入表中。
父类的虚函数，在子类的虚函数的前面。

# 一般继承，有虚函数覆盖
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/10.png)

此时内存中地址如下
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/13.png)

注意，最重要的一点是，地址上，覆盖的f()函数，被放置到了父类的f()函数上。于是就可以有下方的程序
```

	Base *b = new Derive();
	b->f();
```
使用一个类型为Base的指针b指向一个新建的实例Derive()，此时对于指针b指向的虚函数表中，此时f()的地址被Devieive函数的地址被覆盖， 形成如上的虚函数表。

此时访问成功

# 多重继承 无虚函数的覆盖
假设有如上的内容
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14.png)

此时虚函数表
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/15.png)

每个父类都有自己的虚表，子类的成员函数被放到第一个父类的表中。即第一个父类的表是按照声明的顺序来判断。

# 多重继承 有虚函数覆盖
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/16.png)

此时表如下
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/17.png)

此时父类的被替换了。

这样就实现了多重继承，代码如下
```
	Derive d;
	Base1 *b1 = &d;
	Base2 *b2 = &d;
	Base3 *b3 = &d;
	b1->f();
	b2->f();
	b3->f();
```
此时代码如上。

# 纯虚函数
```
virtual int area() = 0;
```
实现一个纯虚函数，此时可以在派生类中更好的定义纯虚函数。


![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/wx.png)
