title: js 中的class
author: Ming ming
tags: []
categories:
  - 前端
  - js
date: 2018-09-20 19:54:00
---
js 的class
由于存在转换器这种神器，所以代码能直接转换为es5，用es6的语法写。
# 一些解释
js的class仅仅为一个语法糖，是在原先构造函数的基础上出现的class，仅仅如此。所以使用构造函数构造类，或者使用class语法糖构造类都是相同的。具体还是使用prototype和this来进行模拟类。
> 重点在于构造函数，使用的是构造函数来模拟类。

# 类声明
需要声明一个类，需要使用class
```
class Rectangle {
	constructor(height, width) {
		this.height = height;
		this.width = width;
	}
}
```
> 和函数声明的最大的区别在于，类声明，不会出现声明提前，函数声明会出现声明提前，这是两者最大的区别。

在上方中，声明类以后，新建一个对象。
```
let rectAngle = new Rectangle
```
该对象具有constructor方法。
## 匿名类
和匿名函数类似，类依旧可以进行匿名声明
```
let Rectangle = class {
	constructor(height, width) {
		this.height = height;
		this.width = width;
	}
}
```
> 在类表达式中，同样会出现类声明提升的问题。

# constructor
为一个构造函数，用于初始化class并创建一个对象
> 即为原先学习的构造函数，函数为对象，对象为函数。

```
class Rectangle {
	// 构造函数
	constructor(height, width) {
		this.height = height;
		this.width = width;
	};
	// get 方法即调用将会返回的值
	get area() {
		return this.calcArea();
	};
	// 定义calcArea函数
	calcArea() {
		return this.height * this.width;
	}
}
```
上方定义了一个类如果需要使用
```
const square = new Rectangle();
console.log(square.area);
```
即可完成对类的使用。
# static
为一个静态方法，该静态new出的来的对象不能进行使用。
> 常常用于工具函数的书写

```
class Point {
	constructor(x, y){
		this.x = x;
		this.y = y;
	};

	static distance(a, b){
		const dx = a.x - b.x;
		const dy = a.y - b.y;
		return Math.hypot(dx, dy);	// 毕达哥拉斯定理
	}
}
// 使用
const p1 = new Point(5,5);
const p2 = new Point(10,10);
console.log(Point.distance(p1,p2));
```
# 关于严格模式
由于js存在严格模式，并且上面的内容在严格模式下执行，如果该对象没有this的值，将不会返回其本身。
> 传统的使用prototype将会返回其本身，因为传统的不在严格模式下执行。

# extends
使用extends创建子类
```
class Animal {
	constructor(name) {
		this.name = name;
	}

	speak() {	// 由于是在类中定义，function关键字可以省去
		console.log(this.name);
	}
}
// 创建DOg父类
class Dog extends Animal {
	speak() {
		console.log(this.name);
	}
}

let d = new Dog();
d.name = "ming"
d.speak();
```
## 类不可继承没有构造函数的对象
如果一个对象没有构造函数，将不能进行继承。
请使用
```
Object.create()
```
进行创建给予对象的新对象
```

const a = {

};

const b = Object.create(a);	// 创建基于原型a的对象
```
# super
使用super调用超类
```

class Cat {
	constructor(name) {
		this.name = name;
	}

	speak() {
		console.log();
	};
}  

class Lion extends Cat {
	speak() {
		super.speak();
	}
}


```
即使用super调用超类