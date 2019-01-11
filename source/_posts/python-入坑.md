title: Python 小入坑
author: Ming ming
tags: []
categories:
  - 后端
  - Python
date: 2018-10-03 06:45:00
---
python入坑
学习的是python3
# 一些信息
官网 https://www.python.org/
官方文档 https://docs.python.org/3/
github https://github.com/python
特点 简单，易学，开发快速
分类 解释型语言，面向对象，动态数据类型的高级语言，其开源遵守GPL协议。支持多种编程范式， 面向对象，函数，过程，命令式。拥有动态类型系统和垃圾回收功能。创始人 Guido van Rossum 属于高阶动态类型编程语言
注：不打算深入学习，基础语法过完，并了解几个框架，一个web框架完成。\~

> 其中c为低级语言，c++为中级语言，python为高级语言

> GPL协议 属于GNU项目的一个分类，由FSF协会撰写。 维基百科  https://en.wikipedia.org/wiki/GNU_General_Public_License  使用的GCC都属于GNU项目里的
 
> 关于 Guido van Rossum 推特 https://twitter.com/gvanrossum 
github https://github.com/gvanrossum  
其个人主页 https://gvanrossum.github.io/Resume.html
目前在Dropbox, Inc.

# 安装
 从官网上下载python，安装，打开powershell输入
 ```
 PS C:\Users\mingm\Desktop> python -V
Python 3.7.0
```
由于使用的是3.7版本，所以查看官方的3.7版本的文档 https://docs.python.org/3.7/

# hello world
其文件后缀名为py
编写py文件
```
print("hello world");
```
编译
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
hello world
PS C:\Users\mingm\Desktop\py>
```
完成输出hello world
# 基础语法
## 注释
注释以#开头
## 行与缩进
用行与缩进代表代码块
## 多行语句
通常用一行写完一条语句，如果语句很长使用反斜杠表示
## 同一行显示多条语句
使用分号表示同一行的多条语句
## print输出
print输出默认是换行的
## 导入包
import 和 form ... import
举例
```
import sys	# 导入sys模块
for i in sys.argv:
	print (i)
print("\n python 的路径为", sys.path)
```
关于sys模块
https://docs.python.org/3.7/library/sys.html#module-sys

一个用于与解释权进行交互的模块

```
from sys import argv,path # 从sys模块导入两个函数 即argv函数，以及path函数

print("path:" + path);	# 输出函数

```
## 命令行参数
使用-h参数，查看命令行的参数
```
PS C:\Users\mingm\Desktop\py> python -h
```
# 基本数据类型
和js一样，属于动态类型的，和Java，c的最大的区别在于属于动态类型的
使用type()函数，查找当前的数据类型
以及一个isinstance()函数，和type()函数的区别在于会认为子类是一种父类的类型
## 字符串
```
str = 'hello world';

print(str);
print(str[0:-2])
```
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
hello world
hello wor
PS C:\Users\mingm\Desktop\py>
```
## 列表
类似于数组
```
list = ['abcd', 786, 2.23, 'hello world', 70.2];
tinyList = [123, 'hello world'];

print(list);	
print(list[0]);
print(list[1:3]);
```
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
['abcd', 786, 2.23, 'hello world', 70.2]
abcd
[786, 2.23]
PS C:\Users\mingm\Desktop\py>
```
## 元组
类似于matlab的元组，不可改变
```
tuple = ('abcd', 786, 2.23, 'hello world', 70.2);
tinytuple = (123, 'hello world');

print(tuple);
print(tuple[0]);
print(tuple + tinytuple);
```
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
('abcd', 786, 2.23, 'hello world', 70.2)
abcd
('abcd', 786, 2.23, 'hello world', 70.2, 123, 'hello world')
PS C:\Users\mingm\Desktop\py>
```
## set 集合
数学中的集合概念
```
student = {'tom', 'Jim', 'Mary', 'Tom'};
print(student);
```
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
{'Jim', 'Tom', 'tom', 'Mary'}
PS C:\Users\mingm\Desktop\py>
```
## 字典 即 键值对
```
dict = {};
dict['one'] = "1";
print(dict['one']);
```
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
1
PS C:\Users\mingm\Desktop\py>
```
# 选择 循环
## 选择
```
var1 = 100;
if var1:
	print ("true");

var2 = 0;
if var2:
	print ("true");
print("bey!");
```
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
true
bey!
PS C:\Users\mingm\Desktop\py>
```
tips: elif 为else if
## 循环
```
n = 100;

sum = 0;
counter = 1;
while counter <= n:
	sum += counter;
	counter += 1;
print("和为%d " % sum);

```
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
和为5050
PS C:\Users\mingm\Desktop\py>
```

### while else 语句
```
count = 0;
while count < 5:
	print(count, "小于 5");
	count += 1;
else:
	print (count, "值大于或等于 5");
```
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
0 小于 5
1 小于 5
2 小于 5
3 小于 5
4 小于 5
5 值大于或等于 5
PS C:\Users\mingm\Desktop\py>
```
### for 语句
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
C
C++
Perl
PS C:\Users\mingm\Desktop\py>
```
```
languages = ["C", "C++", "Perl"];
for x in languages:
	print (x)
	
```
### range()函数
```
for i in range(5):
	print(i)
```
```
PS C:\Users\mingm\Desktop\py> python .\hello.py
0
1
2
3
4
PS C:\Users\mingm\Desktop\py>
```
```
>>> list(range(5));
[0, 1, 2, 3, 4]
>>>
```
### pass语句
pass语句为空语句，

> ps 用google提供的Puppeteer + koa + mongodb即可完成爬数据到数据库中，并且是无敌滴，管你加密与否，只要能给我显示出来，统统可以爬到手，一切的加密统统实效。！ 算了自动化运维还需要py，╮(╯▽╰)╭
