title: 设计模式-创建型模式-工厂模式（工厂三兄弟） TypeScript
author: Ming ming
tags: []
categories:
  - 设计模式
  - 工厂模式
date: 2018-11-27 15:53:00
---
设计模式-创建型模式-工厂模式（工厂三兄弟） TypeScript
# 简单工厂模式
定义一个接口，三个具体类。然后书写如下，通过选择，生产出相应的对象
                            


```
// 定义Shape接口
interface Shape {
	draw():void;
}

// 下面为产品类
// 产品 Circle
class Circle implements Shape{
	public constructor(){

	}

	public draw():void{

	}
}

// 产品Rectangle
class Rectangle implements Shape{
	public constructor(){

	}
	public draw():void{

	}
}

// 下面为生产产品的工厂，根据选择，生产出不同的产品
class ShapeFactory {
	constructor(){

	}
	public static getShape(typeShape:string):Shape{
		if(typeShape === "Circle"){
			return new Circle();
		}

		if (typeShape === "Rectangle"){
			return new Rectangle();
		}

		if (typeShape === null){
			return null;
		}

		return null;
	}
}

// 下面编写测试
let test:Shape = ShapeFactory.getShape("Circle");
// 调用draw方法
test.draw();

```
编译后的js如下
```
// 下面为产品类
// 产品 Circle
var Circle = /** @class */ (function () {
    function Circle() {
    }
    Circle.prototype.draw = function () {
    };
    return Circle;
}());
// 产品Rectangle
var Rectangle = /** @class */ (function () {
    function Rectangle() {
    }
    Rectangle.prototype.draw = function () {
    };
    return Rectangle;
}());
// 下面为生产产品的工厂，根据选择，生产出不同的产品
var ShapeFactory = /** @class */ (function () {
    function ShapeFactory() {
    }
    ShapeFactory.getShape = function (typeShape) {
        if (typeShape === "Circle") {
            return new Circle();
        }
        if (typeShape === "Rectangle") {
            return new Rectangle();
        }
        if (typeShape === null) {
            return null;
        }
        return null;
    };
    return ShapeFactory;
}());
// 下面编写测试
var test = ShapeFactory.getShape("Circle");
// 调用draw方法
test.draw();

```

# 利用反射改进
```
class ShapeFactory1 {
	constructor(){

	};
	public static getShape<T extends Shape>(c:{new ():T}):T{	// C类型为类
		return new c();
	}
}
let test = ShapeFactory1.getShape(Circle);
test.draw();
```
```
var ShapeFactory1 = /** @class */ (function () {
    function ShapeFactory1() {
    }
    ;
    ShapeFactory1.getShape = function (c) {
        return new c();
    };
    return ShapeFactory1;
}());
var test = ShapeFactory1.getShape(Circle);
test.draw();
```

# 工厂方法
即，将工厂拆分
```

// 工厂方法
class CircleFactory{
	constructor(){

	}
	public static getShape():Shape{
		return new Circle();
	}
}
class RectangleFactory{
	constructor(){

	}
	public static getShape():Shape{
		return new Rectangle();
	}
}
let test = CircleFactory.getShape();
test.draw();
```
# 抽象工厂
抽象工厂比较简单不在阐述。
www.iming.info