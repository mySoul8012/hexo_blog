title: C++入坑
author: Ming ming
tags: []
categories:
  - 基础知识
  - C++
date: 2018-10-19 04:13:00
---

一门中级语言，具有面向过程，面向对象的编程范式。
扩展名为cpp

# hello world
使用g++编译
一个C++程序
```
#include <iostream>
using namespace std;
int main()
{
    cout << "Hello, world!" << endl;
    return 0;
}
```
编译
```
PS C:\Users\mingm\Desktop\cpp> g++ hello.cpp
PS C:\Users\mingm\Desktop\cpp>
```
运行
```
PS C:\Users\mingm\Desktop\cpp> C:\Users\mingm\Desktop\cpp\a.exe
Hello, world!
PS C:\Users\mingm\Desktop\cpp>
```
使用ide，clion进行配置。输出如下
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/14/23.png)

# 基本语法
对象，对象具有状态和行为
类，可以定义描述对象的行为的状态和模板
方法，一个方法表示一种行为。
即时变量，对象的状态由即时变量表示
## 基本结构
```
#include <iostream>
using namespace std;

int main(){
	cout << "hello world";	// 输出hello world
	return 0;
}
```
## 数据类型
### 定义一个新的类型
```

	typedef int feet;	// feet为int的另一个名称
	feet distance;	// 创建一个整形变量
```
### 枚举类型
给变量设置一个集合，该变量的值只能从该集合中取为枚举类型。且，转为int类型的初始值为0~6，可以设置其int值

> java也有枚举类型，

```
	enum color {
		red, green, blue
	}c = color(2);	// 枚举类型不能直接赋值，可以强制类型转换进行赋值
	c = blue;	// 可以自己赋值枚举的值
	c = color(0);	
```
枚举不可进行算术运算，可与参与其他类型的运算，会自动转换成为int类型的，并且枚举的数值可以相同。
> 枚举适合和switch搭配

#### 如果不需要转换
请使用class，禁止进行转换

## 变量定义
```
#include <iostream>
using namespace std;

// 变量声明
extern int a,b;

int main(){
	// 变量定义
	int a, b;

	// 变量初始化
	a = 10;

	cout << a << endl;
	
	return 0;
}
```

# C++ 储存类
## register
定义一个储存在寄存器中值，应用场景，计数器
```
register int miles;
```
## static储存类
即，静态变量
## extern 
提供全局变量的引用。在另一个文件声明全局变量和函数

# 循环
```
#include <iostream>
using namespace std;

int main(){
	for(int i = 0; i <= 10; i++){
		cout<< i << endl;
	}
}
```
# 判断
# 函数
```
#include <iostream>
using namespace std;

// 函数声明
int max(int num1, int num2);

int main(){
	int a = 100;
	int b = 200;
	int ret;

	ret = max(a,b);

	cout << ret << endl;

	return 0;
}

// 函数返回较大的数
int max(int num1, int num2){
	int result;

	if(num1 > num2)
		result = num1;
	else
		result = num2;

	return result;
}
```
## 函数调用的默认值
```
// 函数返回较大的数
int max(int num1, int num2 = 20){
	int result;

	if(num1 > num2)
		result = num1;
	else
		result = num2;

	return result;
}
```
如果调用的时候未添加值，将会直接使用默认值

## 匿名函数
> 看到这个词好亲切

匿名函数，将函数看成对象，函数可以像对象一样使用。
其格式为
```
[](){}
```
第一个[]为值的获取，（js中有用闭包获取值的）第二个为返回值，第三个为函数体
```
#include <iostream>
using namespace std;

int main(){
    int i = 1024;
    auto func = [=]{    // 表明外部变量为拷贝
        cout << i << endl;
    };
}
```
```
#include <iostream>
using namespace std;

int main(){
    int i = 1024;
    cout << &i << endl;
    auto fun1 = [&]{    // 进行引用
        cout << &i << endl;
    };
}
```
```
#include <iostream>
using namespace std;

int main(){
    int i = 1024, j = 2048;

    cout << j << endl;
    cout << i << endl;

    auto fun1 = [=, &i]{    // 拷贝外部变量，但引用i
        cout << i << &i << endl;
        cout << j << &j << endl;
    };
    fun1();
}
```

> this 为指向其对象的类

# 数字
## 随机数
设置种子。生成伪随机数
```
#include <iostream>
#include <ctime>
#include <cstdlib>

using namespace std;

int main(){
	int i,j;

	// 设置种子
	srand((unsigned)time(NULL));	// 根据系统当前时间，设置种子

	cout << "生成随机数" << endl;
	//生成10个随机数
	for(i = 0; i < 10; i++){
		// 生成随机数
		j = rand();
		cout << "随机数" << j << endl;
	}

	return 0;
}
```
# 数组
C++支持数组的数据结构
```
#include <iostream>
using namespace std;

#include <iomanip>
using std::setw;

int main(){
	int n[10];	// n 是一个包含10个整数的数组

	// 初始化数组
	for(int i = 0; i < 10; i++){
		n[i] = i + 100;	// 设置元素的值
	}
	cout << "Element" << setw(13) << "value" << endl;

	// 输出数组
	for(int j = 0; j < 10; j++){
		cout << setw(7) << j << setw(13) << n[j] << endl;
	}

	return 0;
}
```
```
PS C:\Users\mingm\Desktop\cpp> C:\Users\mingm\Desktop\cpp\a.exe
Element        value
      0          100
      1          101
      2          102
      3          103
      4          104
      5          105
      6          106
      7          107
      8          108
      9          109
PS C:\Users\mingm\Desktop\cpp>
```

# 字符串
C风格字符串
C++引入string类型类
```
#include <iostream>
#include <string>

using namespace std;

int main(){
	string str1 = "hello";
	string str2 = "world";
	string str3;
	int len;

	// 复制数组
	str3 = str1;
	cout << "str3: " << str3 << endl;

	// 连接string
	str3 = str1 + str2;
	cout << "str1 + str2; " << str3 << endl;

	// 计算连接后长度，使用size()方法
	len = str3.size();
	cout << "str3.size():" << len << endl;

	return 0;
}
```
```
PS C:\Users\mingm\Desktop\cpp> C:\Users\mingm\Desktop\cpp\a.exe
str3: hello
str1 + str2; helloworld
str3.size():10
PS C:\Users\mingm\Desktop\cpp>
```
## C++指针
和C指针一样

## 引用
和指针区别
1. 不存在空引用
2. 一旦被初始化为对象，不能更改引用的对象
3. 引用必须在创建的时候初始化

属于别名

### 引用作为参数
```
#include <iostream>
#include <string>

using namespace std;

void swqp(int& x, int& y);

int main(){
    // 声明
    int a = 100;
    int b = 200;
    int& c = a;
    cout << c << "C的值" << endl;
    cout << &c << "C的地址" << endl;
    cout << a << "a的值" << endl;
    cout << &a << "a的地址" << endl;   // 验证对于引用来说，地址为相同的。

    cout << "交换前，a的值" << a << endl;
    cout << "交换前，b的值" << b << endl;

    /*调用函数交换值*/
    swap(a,b);

    cout << "交换前，a的值" << a << endl;
    cout << "交换前，b的值" << b << endl;

    return 0;

}

// 函数定义
void swap(int& x, int& y){
    int temp;
    temp = x;	// 进行的是地址交换
    x = y;
    y = temp;

    return;
}
```
除此之外，引用还可以作为函数的返回值进行返回

# 日期，时间
获取当前日期和时间
```
#include <iostream>
#include <ctime>

using namespace std;

int main(){
    time_t now = time(0);

    char* dt = ctime(&now);

    cout << "本地日期时间" << dt << endl;

    tm *Itm = localtime(&now);

    // 输出结构的各个部分
    cout << "year" << 1900 + Itm->tm_year << endl;	// unix时间
    return 0;
}
```
# 输入输出
## cout
标准输出流
endl表明添加一个换行符
## cin
标准输入流
```
#include <iostream>

using namespace std;

int main(){
    char name[50];

    cout << "请输入名称";
    cin >> name;	// 将输入流输入name变量中
    cout << "您的名称为" << name << endl;
}
```
与流提取运算符联合使用
# C++结构体
和C语言并无两样。