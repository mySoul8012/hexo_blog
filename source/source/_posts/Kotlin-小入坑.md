title: Kotlin 小入坑
author: Ming ming
tags: []
categories:
  - 安卓
  - Kotlin
date: 2018-09-25 22:43:00
---
Kotlin入坑
小入坑Kotlin
# 介绍
一种运行在Java上运行的静态类型的编程语言，被称为安卓界的swfit 
Kotlin既可以编译成为Java字节码，在jvm上运行，也可以编译成JavaScript。
# 安装 
最先开始的是使用命令行进行编译。
工具 github项目地址 https://github.com/JetBrains/kotlin/releases
接着设置环境变量
检验是否安装成功
输入
```
PS C:\Users\mingm\Desktop> kotlinc -version
Active code page: 65001
info: kotlinc-jvm 1.2.71 (JRE 1.8.0_144-_2017_08_24_19_19-b00)
```
检验是否安装成功
接着编译第一个程序
# 第一个程序
```
fun main(args: Array<String>) {
	println("hello world");
}
```
接着执行编译
```
kotlinc hello.kt -include-runtime -d hello.jar
```
其中include-runtime为jar文件包含kotlin库，从而可以直接运行。
-d为生成的jar文件
接着运行jar文件
```
PS C:\Users\mingm\Desktop\java> java -jar hello.jar
hello world
PS C:\Users\mingm\Desktop\java>
```
然后输入hello world表明编译完成。