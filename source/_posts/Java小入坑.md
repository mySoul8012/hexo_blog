title: Java小入坑
author: Ming ming
tags: []
categories:
  - 后端
  - Java
date: 2018-09-18 23:38:00
---
Java入坑指南
是滴，下面是一个最低的入坑
> 还应该有23种设计模式应该掌握的。╮(╯▽╰)╭
> 注意，第一个j是大写。

Java的特点跨平台，风格接近C++
最重要的api文档 https://docs.oracle.com/javase/10/docs/api/overview-summary.html
# 语言特点
1. 面向对象
2.  跨平台，运行在JRE上，JRE包括JVM
3. 具有自动垃圾回收的机制
属于强类型，简单，面向对象，分布式，健壮的，安全的，可移植的，解释型语言（将会翻译成字节码，在JVM上运行），高性能，动态，多线程。
# 开发工具
JDK，一个工具包，面向开发者的工具包，包含JVM。
JRE，一个Java的运行环境，分为服务器端的运行环境和开发者的运行环境。服务器端部署Java的时候，需要使用JRE运行Java程序。

# 体系
分为三个体系，分别是J2SE，J2EE，J2ME
分别为以上三个体系。
# 专业术语
JDK 编写Java程序的程序员使用的软件
JRE 运行Java程序的用户使用的软件
Server JRE 运行Java程序的服务器使用的软件
SDK 软件开发工具包
DAO 数据访问的接口
MVC 一种模式
JSP 一种在HTML中写入Java的方式，由服务器端进行渲染，然后返回给用户（已经用的很少喽，目前都是直接封装成为API的，其接口设计需要遵守RESTful API的设计规范，属于一种架构方式，可以使用https://swagger.io/对api进行设计，jsp类似于php都是直接写在HTML内的~）
Servlet  一种封装成http的接口，然后通过http请求来访问，使用这个Java能更加注重后端的业务的逻辑，实现解耦。（这个日后需要在继续学习）
JDBC 一种连接方式，用来连接数据库例如Mysql
Tomcat 一种运行Servlet的容器，在服务器端运行
SSH框架 包括Hibernate5框架、Struts2框架、Spring4框架
SSM框架 Spring、SpringMVC和Mybatis框架。
RPC框架 客户端在不知道调用细节的情况下，调用存在于远程计算机上的某个对象，就像调用本地应用程序中的对象一样 用于分布式。经典框架 https://thrift.apache.org/ 来自于FaceBook



# OOP
一种编程范式，
## 类与对象
类（Class）：定义了一件事物的抽象特点。类的定义包含了数据的形式以及对数据的操作。
对象：是类的实例。
## 动态配置与消息传递
定义上动态配置是指方法会随着实例动态的改变。而消息传递机制（Message Passing）是指一个对象通过接受消息、处理消息、传出消息或使用其他类的方法来实现一定功能。
## 封装
具备封装性（Encapsulation）的面向对象编程隐藏了某一方法的具体运行步骤，取而代之的是通过消息传递机制发送消息给它。
## 继承
继承性（Inheritance）是指，在某种情况下，一个类会有“子类”。
## 多态
多态（Polymorphism）是指由继承而产生的相关的不同的类，其对象对同一消息会做出不同的响应。
## 抽象
抽象（Abstraction）是简化复杂的现实问题的途径，它可以为具体问题找到最恰当的类定义，并且可以在最恰当的继承级别解释问题。
## 语言
C→C++，C→Objective-C，BASIC→Visual Basic→Visual Basic .NET，Pascal→Object Pascal，Ada→Ada95

## 脚本化中的面向对象
Python和Ruby
Perl和PHP
> Java和js有非常大的区别，一个是脚本，一个不是脚本。Java不是脚本，是编译成字节码然后在jvm上运行的。

# Java语言编译的过程
Java代码编译是由Java源码编译器来完成，也就是Java代码到JVM字节码（.class文件）的过程
Java字节码的执行是由JVM执行引擎来完成
> 将jvm比喻成操作系统，Java只是又新建了一个类似于操作系统，术语叫虚拟机，用来运行Java的字节码

## Java代码编译和执行的机制
### 源码编译
①分析和输入到符号表

②注解处理

③语义分析和生成class文件

最后生成的class文件包含以下内容
①结构信息：包括class文件格式版本号及各部分的数量与大小的信息

②元数据：对应于Java源码中声明与常量的信息。包含类/继承的超类/实现的接口的声明信息、域与方法声明信息和常量池

③方法信息：对应Java源码中语句和表达式对应的信息。包含字节码、异常处理器表、求值栈与局部变量区大小、求值栈的类型记录、调试符号信息

### 类的加载机制
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/16/5.png)
一张图说明，先自底向上检查类是否加载，进行记录，然后全部将类检查完成以后，再自顶向下不断的尝试加载类。
> 底层使用C++完成对类的加载

### 类的执行机制
JVM是基于堆栈的虚拟机，JVM为每个新创建的线程分配一个堆栈，对于Java程序来说，运行时通过对堆栈的操作来完成的。
堆栈以帧为单位保存线程的状态，JVM对堆栈的操作为压栈和出栈
JVM执行class字节码以后，将会产生程序计数器和栈，程序计数器存放将要执行下一条指令的偏移量。
栈中存放一个个的栈帧，每个栈帧对应每个方法的每次调用，栈帧由局部变量和操作数栈两部分组成，局部变量存放局部变量和参数，操作数栈中用于存放方法执行过程中产生的中间结果
### JVM内存管理和垃圾回收
JVM内存分为方法区（method），栈内存（stack），堆内存（heap），本地方法栈（java中的jni调用）
#### 堆内存
操作系统有一个记录空闲内存地址的**链表**，当系统收到程序的申请时，会遍历该链表，寻找第一个空间大于所申请空间的堆结点，然后将该结点从空闲结点链表中删除，并将该结点的空间分配给程序，
#### 栈内存
栈是向低地址扩展的数据结构。为一块连续的内存区域。
> 会有栈溢出这种情况

其中对象保存在堆中，变量和其中的中间结果保存在栈中
#### 垃圾回收机制
如果一个对象没有其他对象进行引用，将会进行不定时的进行删除，即对无用的内存空间进行回收。
#### 类加载的流程图
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/16/6.png)

# 开发环境
官方教程 https://docs.oracle.com/javase/10/install/installation-jdk-and-jre-microsoft-windows-platforms.htm#JSJIG-GUID-A7E27B90-A28D-4237-9383-A58B416071CA
windows上安装JDK。
进入oracle官网，https://www.oracle.com/index.html
选择，https://www.oracle.com/technetwork/java/javase/downloads/index.html
目前最新的J2EE为10.0.2
选择jdk 即面向开发者的https://www.oracle.com/technetwork/java/javase/downloads/jdk10-downloads-4416644.html
由于目前是在windows版本，选择windows版本的。
单击下一步即可，所有的都会帮你设置完成。
打开PowerShell 输入
```
PS C:\Users\mingm\Desktop> java -version
java version "10.0.2" 2018-07-17
Java(TM) SE Runtime Environment 18.3 (build 10.0.2+13)
Java HotSpot(TM) 64-Bit Server VM 18.3 (build 10.0.2+13, mixed mode)
PS C:\Users\mingm\Desktop>
```
如果能出现以上命令说明配置正确。path等环境变量已经自动配置
## Server JRE
一种运行在服务器端的Java环境。链接https://www.oracle.com/technetwork/java/javase/downloads/index.html
选择进行下载。
在win10 设置中设置环境变量
http://www.runoob.com/w3cnote/windows10-java-setup.html
## Eclipse
一种Java的IDE环境https://www.eclipse.org/
选择java环境文件，即可完成，灰常简单。由于某些让人气愤的原因，包无法使用，那就用https://www.eclipse.org/downloads/packages/

# hello world
现在书写第一个hello world程序
```
public class HelloWorld {
	/*你好世界！*/
	public static void main(String []args) {
		System.out.println("hello world");
	}
}

```
新建HelloWorld.java文件
然后打开同目录下的powershell
编译成为class
```
PS C:\Users\mingm\Desktop\test> javac .\HelloWorld.java
```
出现错误
```
.\HelloWorld.java:2: :  GBK Ĳӳַ (0x81)
        /*你好世界?*/
                 ^
1
```
提示编码错误，由于保存的是utf-8编码的，所以直接代码编码进行编译。
```
PS C:\Users\mingm\Desktop\test> javac -encoding utf-8 .\HelloWorld.java
```
使用
```
-encoding
```
编码使用utf-8进行编译成为class文件
查看目录
```
PS C:\Users\mingm\Desktop\test> ls


    目录: C:\Users\mingm\Desktop\test


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2018/9/18     22:14            425 HelloWorld.class
-a----        2018/9/18     22:12            135 HelloWorld.java


PS C:\Users\mingm\Desktop\test>
```
目录下出现class文件
继续运行
```
PS C:\Users\mingm\Desktop\test> java HelloWorld
hello world
PS C:\Users\mingm\Desktop\test>
```
出现hello world
## 在Eclipse上写hello world
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/16/9.png)

接着书写项目名称
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/16/8.png)

接着在src目录下创建包
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/16/10.png)

创建Java源文件
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/16/11.png)

书写代码
```
package cn.xd.test;

public class Hello {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("hello world");
	}

}
```
运行
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/16/13.png)

运行结果
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/16/14.png)

> 评价，不习惯用IDE，至今不知道为什么。╮(╯▽╰)╭。习惯使然。
## IntelliJ idea
> ps 试试这个，如果能适应TJ的话，那更加的好啦。

和jre连接
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/09/16/15.png)


比较简单，不在阐述，
综上所述，个人还是倾向于简单应用直接编辑器，submit text 就行啦，稍微复杂一点的应用，使用IntelliJ idea 即可。

