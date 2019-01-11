title: C++命名空间
author: Ming ming
tags: []
categories:
  - 基础知识
  - C++
date: 2018-11-07 16:37:00
---
# C++ 命名空间
C++为了区分多个xyz的函数的时候，需要使用命名空间进行区分。
## 定义命名空间
```
#include <iostream>
using namespace std;

// 第一个命名空间
namespace first_space{
	void func(){
		cout << "func_first_space" << endl;
	}
}

// 第二个命名空间
namespace second_space{
	void func(){
		cout << "second_space_func" << endl;
	}
}

int main(){
	// 调用第一个命名空间的函数
	first_space::func();	// 调用first_space命名空间下的func函数

	// 调用第二个命名空间的函数
	second_space::func();	// 调用second_space命名空间的fuc函数

	return 0;
}
```
```
PS C:\Users\mingm\Desktop\cpp> ./a.exe
func_first_space
second_space_func
```
## using
使用using告诉编译器使用哪个命名空间。
```
#include <iostream>
using namespace std;	// 使用了默认的主命名空间

// 第一个命名空间
namespace first_space{
	void func(){
		cout << "first_space" << endl;
	}
}

// 第二个命名空间
namespace second_space{
	void func(){
		cout << "second_space" << endl;
	}
}

using namespace first_space;	// 使用了first_space作为命名空间
int main(){
	// 调用第一个命名空间的函数
	func();

	return 0;
}
```
## 其他
命名空间可以不连续，可以嵌套

# 模板
模板是创建泛型类或函数的蓝图和公式。
> 库容器，迭代器，算法，都是泛型的栗子

```
#include <iostream>
#include <string>

using namespace std;

template<typename T>	// T为函数所使用的数据类型的占位符名称。
inline T const& Max(T const& a, T const& b){	// 使用内联函数 inline
	return a < b ? b:a;
}
int main(){
	int i = 39;
	int j = 20;
	cout << " " << Max(i,j) << endl;	// 此时T为int类型 

	double f1 = 13.5;
	double f2 = 20.7;
	cout << " " << Max(i, j) << endl;	// 此时T为double类型

	return 0;
}
```
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/wx.png)
www.iming.info