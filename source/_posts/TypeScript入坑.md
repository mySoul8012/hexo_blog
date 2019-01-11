title: TypeScript入坑
author: Ming ming
tags: []
categories:
  - 前端
  - TypeScript
  - ''
date: 2018-10-18 17:40:00
---
TypeScript 入坑
# 安装
使用npm安装
使用全局方式安装
```
npm install -g typescript
```
# 编辑器
安装插件 https://github.com/Microsoft/TypeScript-Sublime-Plugin
https://packagecontrol.io/packages/TypeScript
编译使用node.js进行编译
# hello world
编写ts文件
```
function greeter(person) {
	return "Hello world!" + person;
}
let user = "hello world";

document.body.innerHTML = greeter(user);
```
编译
```

PS C:\Users\mingm\Desktop\ts> tsc greeter.ts
Active code page: 65001
PS C:\Users\mingm\Desktop\ts>
```

上方为编译好的js文件
```
function greeter(person) {
    return "Hello world!" + person;
}
var user = "hello world";
document.body.innerHTML = greeter(user);

```
# 类型注解
```
function greeter(person: string){	// 将其注解为string类型
	return "hello," + person;
}

let user = [0, 1, 2];
document.body.innerHTML = greeter(user);
```
将其注解为string类型
# 变量声明
由于js没有块级作用域，使用var会出现以下问题
```
for(var i = 1: i <= 10; i++) {
}
console.log(i);
```
仍然可以访问i为10，由于js的变量作用注册在作用域链上造成的结果，解决方案，使用闭包
## let
let属于块级作用域
## const 
赋值以后不能再改变
## 解构赋值
```
let input = [1,2];
let input1 = [2,3];
// 解构赋值
[input[0], input[2]] = [2,3]
// 同样的也可以创建剩余变量
let[first,...rest] = [1,2,3,4,5];
// first 为 1， rest 为[2,3,4,5]
```
## 联合类型
```
let myFavoriteNumber: string | number
myFavoriteNumber = "seven";
myFavoriteNumber = 7;
```
```
var myFavoriteNumber;
myFavoriteNumber = "seven";
myFavoriteNumber = 7;
```
## 访问联合类型的属性和方法
> 只能访问共有的属性和方法

```
function getString(something:string | number):string {
	return something.toString();
}
```
```
function getString(something) {
    return something.toString();
}
```

# 接口
对类的一部分行为进行抽象（即方法）抽象出接口。
> 防盗门和车都有报警这个方法，将报警这个方法抽象出来，成为这两个的接口

接口建议名称前加上I
```
// 定义一个接口，接口的类型名称为person
interface Iperson{
	name: string;
	age: number;
}

// 使用接口
function greeter(person: Iperson):string {
	return "hello world" + person.name + person.age;
}

// 传入对象
let user = { name: "hello world", age: 23 };
// 调用
document.body.innerHTML = greeter(user);
```
```
// 使用接口
function greeter(person) {
    return "hello world" + person.name + person.age;
}
// 传入对象
var user = { name: "hello world", age: 23 };
// 调用
document.body.innerHTML = greeter(user);
```
## 可选属性
```
// 定义一个接口，接口的类型名称为person
interface Iperson{
	name: string;
	age?: number;
}

// 使用接口
function greeter(person: Iperson):string {
	return "hello world" + person.name + person.age;
}

// 传入对象
let user = { name: "hello world"};
// 调用
document.body.innerHTML = greeter(user);


```
```
// 使用接口
function greeter(person) {
    return "hello world" + person.name + person.age;
}
// 传入对象
var user = { name: "hello world" };
// 调用
document.body.innerHTML = greeter(user);
```
## 接口传入任意值
```
// 定义一个接口，接口的类型名称为person
interface Iperson{
	name: string;
	age?: number;
	[propName: string]: any;	// 任意数据取string类型的值
}

// 使用接口
function greeter(person: Iperson):string {
	return "hello world" + person.name + person.age + person.ming;
}

// 传入对象
let user = { name: "hello world", ming:"hello world"};
// 调用
document.body.innerHTML = greeter(user);
```
