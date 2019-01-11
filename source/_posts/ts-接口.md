title: TypeScript 接口
author: Ming ming
tags: []
categories:
  - 前端
  - TypeScript
date: 2018-10-21 03:16:00
---
TypeScript
接口
# 接口只读属性
使用关键字readonly定义只读的接口属性
```
interface Point {
	readonly x: number;
	readonly y: number;
}
```
```
// 定义一个接口
interface Point{
	readonly x: number;
	readonly y: number;
}

// 对接口赋值
let p1: Point = { x: 10, y: 20 };
p1.x = 5;	// 该句错误，不能进行赋值操作

```
出现错误，如下
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/21/0.png)

# 创建不可修改的数组
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/21/1.png)
```
// 定义一个接口
interface Point{
	readonly x: number;
	readonly y: number;
}

// 对接口赋值
let p1: Point = { x: 10, y: 20 };
//p1.x = 5;	// 该句错误，不能进行赋值操作

let a: number[] = [1, 2, 3, 4, 5];
let ro: ReadonlyArray<number> = a;	// 设置为只读的数组
ro[0] = 12; // 不可进行赋值。出现赋值错误
```

如果想要重新赋值，断言重写
> 当一个值有多个类型的时候，使用断言重写，确定一个新的类型

```
// 定义一个接口
interface Point{
	readonly x: number;
	readonly y: number;
}

// 对接口赋值
let p1: Point = { x: 10, y: 20 };
//p1.x = 5;	// 该句错误，不能进行赋值操作

let a = [2, 3, 4, 5];
let ro: ReadonlyArray<number> = [2, 3, 4, 5];
//ro[0] = 12;	// 不可进行赋值
// 如果需要赋值，使用断言重写
a = ro as number[];	// 进行断言重写

```
```
// 对接口赋值
var p1 = { x: 10, y: 20 };
//p1.x = 5;	// 该句错误，不能进行赋值操作
var a = [2, 3, 4, 5];
var ro = [2, 3, 4, 5];
//ro[0] = 12;	// 不可进行赋值
// 如果需要赋值，使用断言重写
a = ro; // 进行断言重写
//# sourceMappingURL=out.js.map
```
> 类型断言很大程度上可以规范类型

# 函数类型的接口
```
// 定义一个函数类型的接口
interface SearchFunc {
	(source: string, subString: string): boolean;	// 定义一个函数类型的接口
}

// 使用这个接口
let mySearch: SearchFunc;
mySearch = (source:string,subString:string) => {
	let result = source.search(subString);	// 两个字符串正则匹配
	return result > -1;
}
```
```
// 使用这个接口
var mySearch;
mySearch = function (source, subString) {
    var result = source.search(subString); // 两个字符串正则匹配
    return result > -1;
};
//# sourceMappingURL=out.js.map
```
编译器会逐个检查，如果统统正确，则编译通过，否则编译不通过

#  定义索引接口
```
// 定义索引接口
interface StringArray {
	[index: number]: string;
}

let myArray: StringArray;	// 定义一个myArray的变量，类型为索引接口
myArray = ["Bob", "Fred"];

let myStr: string = myArray[0];	// 取第一个值

```
```
var myArray; // 定义一个myArray的变量，类型为索引接口
myArray = ["Bob", "Fred"];
var myStr = myArray[0]; // 取第一个值
//# sourceMappingURL=out.js.map
```

索引值内部必须全部为number类型的
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/21/2.png)
```
// 定义接口,一个索引值类型的，其返回值也为索引类型的
interface NumberDictionary{
	[index: string]: number;
	length: number;	// 可以设置length
	name: string;	// 错误索引值内部不能拥有string类型
}
```
编译一下出现错误

索引签名依旧可以设置为只读，此时可以防止给索引赋值。使用关键字readonly
```
// 定义接口
interface NumberDictionary {
	readonly [index: number]: string;
}

// 初始化一个变量
let myArray: NumberDictionary = ["hello", "world"];
```
顺带配置一下配置文件
```
// tsconfig.json
{
    "compilerOptions": {
        "out": "built/out.js", 
        "sourceMap": true, 
        "target": "es5"
    }, 
    "files": [
        "greeter.ts"
    ]
}
```
```
// out.js
// 初始化一个变量
var myArray = ["hello", "world"];
//# sourceMappingURL=out.js.map
```
```
// 定义接口
interface NumberDictionary {
	readonly [index: number]: string;
}

// 初始化一个变量
let myArray: NumberDictionary = ["hello", "world"];

// 此时进行赋值为错误的
myArray[2] = "hello world";
```
# 类类型
明确一个类去符合一种接口
```
// 定义接口
interface ClockInterFace {
	currentTime: Date;
}

class Clock implements ClockInterFace {	// 使用implements 关键字clock类符合接口clockInterFace
	currentTime: Date;
	constructor(h:number, m:number){
		// 定义构造函数
	}
}
```
// 注意在上方中并不会对静态的，进行检查。只会对非静态的部分，即非构造函数部分进行检查
```
var Clock = /** @class */ (function () {
    function Clock(h, m) {
        // 定义构造函数
    }
    return Clock;
}());
//# sourceMappingURL=out.js.map
```
如果配置成为es6即
```
{
    "compilerOptions": {
        "out": "built/out.js", 
        "sourceMap": true, 
        "target": "es6"
    }, 
    "files": [
        "greeter.ts"
    ]
}
```
```
class Clock {
    constructor(h, m) {
        // 定义构造函数
    }
}
//# sourceMappingURL=out.js.map
```
# 接口描述方法，类实现
```
interface ClockInterface {
	currentTime: Date;
	setTime(d: Date);	// 定义接口的方法
}

class Clock implements ClockInterface{
	currentTime: Date;	// 接口检查的
	setTime(d:Date){	// 接口检查的方法
		this.currentTime = d;
	}
	constructor(h:number, m:number){	// 接口不会检查静态的构造方法

	}
}
```
```
var Clock = /** @class */ (function () {
    function Clock(h, m) {
    }
    Clock.prototype.setTime = function (d) {
        this.currentTime = d;
    };
    return Clock;
}());
//# sourceMappingURL=out.js.map
```
# 关于构造函数的接口
构造函数属于静态的方法，当构造器定义了一个静态的方法的时候。构造器只检查动态的方法，并不会检查动态的方法，故，下方的写法编译器不通过
```
interface ClockConstructor {
	new (hour: number, minuter: number);	// 定义构造函数的接口
};

class clock implements ClockConstructor {
	currenTime: Date;
	constructor(h:number, m:number){	// 接口限制的是此构造函数

	}
}interface ClockConstructor {
	new (hour: number, minuter: number);	// 定义构造函数的接口
};

class clock implements ClockConstructor {
	currenTime: Date;
	constructor(h:number, m:number){	// 接口限制的是此构造函数

	}
}interface ClockConstructor {
	new (hour: number, minuter: number);	// 定义构造函数的接口
};

class clock implements ClockConstructor {
	currenTime: Date;
	constructor(h:number, m:number){	// 接口限制的是此构造函数

	}
}interface ClockConstructor {
	new (hour: number, minuter: number);	// 定义构造函数的接口
};

class clock implements ClockConstructor {
	currenTime: Date;
	constructor(h:number, m:number){	// 接口限制的是此构造函数

	}
}interface ClockConstructor {
	new (hour: number, minuter: number);	// 定义构造函数的接口
};

class clock implements ClockConstructor {
	currenTime: Date;
	constructor(h:number, m:number){	// 接口限制的是此构造函数

	}
}interface ClockConstructor {
	new (hour: number, minuter: number);	// 定义构造函数的接口
};

class clock implements ClockConstructor {
	currenTime: Date;
	constructor(h:number, m:number){	// 接口限制的是此构造函数

	}
}
```
编译
```
PS C:\Users\mingm\Desktop\ts> tsc
Active code page: 65001
greeter.ts:5:7 - error TS2420: Class 'clock' incorrectly implements interface 'ClockConstructor'.
  Type 'clock' provides no match for the signature 'new (hour: number, minuter: number): any'.

5 class clock implements ClockConstructor {
        ~~~~~

PS C:\Users\mingm\Desktop\ts>
```
出现错误

解决，既然不会对静态的构造方法进行检查，那就在创建一个接口，进行更进一步的静态方法的检查。
即，创建一个接口，返回一个接口，这样就会对该构造方法进行检查。
> 类似于类和父类的关系，子类，父类，超类，超类会返回一个类，会调用超类的构造方法，生成子类，此时在这个过程中会进行接口的检查。

```
// 定义一个用于检查构造函数的接口，该接口需要返回一个接口
interface ClockConstructor{
	new (hour: number, minute: number): ClockInterface;
}
// 继续定义一个接口，该接口接收来自上一个接口返回的内容，进行验证
interface ClockInterface {
	tick();	
}
// 创建一个函数，返回一个函数（该函数再次执行）
function createClock(ctor: ClockConstructor, hour:number, minute:number):ClockInterface{
	return new ctor(hour, minute);	
}

// 定义一个类
class DigitalClock implements ClockInterface {	// 下层接口
	constructo(h: number, m: number) { };
	tick(){
		console.log("！！！");
	}
}

// 定义一个类
class AnalogClock implements ClockInterface {
	constructor(h: number, m: number) { };
	tick(){
		console.log("!!!!!!!!");
	}
}

// 调用租函数，传入一个类，返回一个对象
let digital = createClock(DigitalClock, 12, 17);
let analog = createClock(AnalogClock, 2, 4);

```
上方的核心在于创建了两个接口，一个接口用于检查父的内容，一个接口用于进行创建对象进行验证。父的拥有一个函数，传入一个类，并对其进行检查。
```
// 创建一个函数，返回一个函数（该函数再次执行）
function createClock(ctor, hour, minute) {
    return new ctor(hour, minute); // 
}
// 定义一个类
var DigitalClock = /** @class */ (function () {
    function DigitalClock() {
    }
    DigitalClock.prototype.constructo = function (h, m) { };
    ;
    DigitalClock.prototype.tick = function () {
        console.log("！！！");
    };
    return DigitalClock;
}());
// 定义一个类
var AnalogClock = /** @class */ (function () {
    function AnalogClock(h, m) {
    }
    ;
    AnalogClock.prototype.tick = function () {
        console.log("!!!!!!!!");
    };
    return AnalogClock;
}());
// 调用租函数，传入一个类，返回一个对象
var digital = createClock(DigitalClock, 12, 17);
var analog = createClock(AnalogClock, 2, 4);
//# sourceMappingURL=out.js.map
```
```
// 创建一个函数，返回一个函数（该函数再次执行）
function createClock(ctor, hour, minute) {
    return new ctor(hour, minute); // 此处类似于js中的闭包问题
}
// 定义一个类
class DigitalClock {
    constructo(h, m) { }
    ;
    tick() {
        console.log("！！！");
    }
}
// 定义一个类
class AnalogClock {
    constructor(h, m) { }
    ;
    tick() {
        console.log("!!!!!!!!");
    }
}
// 调用租函数，传入一个类，返回一个对象
let digital = createClock(DigitalClock, 12, 17);
let analog = createClock(AnalogClock, 2, 4);
//# sourceMappingURL=out.js.map
```
# 继承接口
类能继承，那么接口也能继承
```
// 接口
interface Shape {
	color: string;
}
// 一个继承接口
interface Square extends Shape {
	sideLength: number;	
}

let square = {} as Square;	//类型断言
square.color = "blue";
square.sideLength = 10; 

```
```
var square = {}; //类型断言
square.color = "blue";
square.sideLength = 10;
//# sourceMappingURL=out.js.map
```
也可以进行从多个接口继承，即创造出合成接口
```
interface Shape{
	color: string;
}

interface penStroke{
	penWidth: number;
}

// 从两个接口继承而来的接口
interface Square extends Shape, penStroke{
	sideLength: number;
}

let square = <Square>{};
square.color = "blue";
square.sideLength = 10;
square.penWidth = 5.0;
```
```
var square = {};
square.color = "blue";
square.sideLength = 10;
square.penWidth = 5.0;
//# sourceMappingURL=out.js.map
```
# 混合类型
对象既可为函数，又可为对象
```
interface Counter {
	(start: number): string;	// 函数
	interval: number;
	reset(): void;
}

// 下面将会书写闭包
function getConter():Counter{	// 返回将会是一个接口类型的
	let counter = <Counter>function (start: number){};	// 类型断言
	counter.interval = 123;
	counter.reset = () => { };
	return counter;	// 返回一个函数
}

let c = getConter();
c(10);
c.reset();
c.interval = 5.0;
```
```
// 下面将会书写闭包
function getConter() {
    var counter = function (start) { }; // 类型断言
    counter.interval = 123;
    counter.reset = function () { };
    return counter; // 返回一个函数
}
var c = getConter();
c(10);
c.reset();
c.interval = 5.0;
//# sourceMappingURL=out.js.map
```

# 接口继承类
接口继承类时，会继承类成员，但不包含其实现。
即，接口声明了类中的成员，但并没有提供具体的实现。
接口同样会继承private（私有的），和protected（对于本包和子同样可见）
> 根据上述的说明，可以知道，当一个接口，继承自拥有protected的类的时候，此时该接口只能被子类，或者该类使用。

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/10/21/5.png)

```
class Control {
	private state: any;	// 定义一个任何类型的私有属性
}

// 定义一个接口，该接口继承自Control
interface SelectableControl extends Control {
	select(): void;
}

// 定义一个子类，该类继承自Control,并使用接口SelectableControl，由于是子类，可以使用SelectableControl接口
class Button extends Control implements SelectableControl {
	select() { };
}

// 定义一个子类该类继承自Control
class TextBox extends Control {
	select(){}
}

// 定义一个Image类，该类不能使用SelectableControl接口
//class Image implements SelectableControl{

//}

// 和其余类没有任何继承关系的类
class Liaction {

}
```
es5 js如下
```
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    }
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var Control = /** @class */ (function () {
    function Control() {
    }
    return Control;
}());
// 定义一个子类，该类继承自Control,并使用接口SelectableControl，由于是子类，可以使用SelectableControl接口
var Button = /** @class */ (function (_super) {
    __extends(Button, _super);
    function Button() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    Button.prototype.select = function () { };
    ;
    return Button;
}(Control));
// 定义一个子类该类继承自Control
var TextBox = /** @class */ (function (_super) {
    __extends(TextBox, _super);
    function TextBox() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    TextBox.prototype.select = function () { };
    return TextBox;
}(Control));
// 定义一个Image类，该类不能使用SelectableControl接口
//class Image implements SelectableControl{
//}
// 和其余类没有任何继承关系的类
var Liaction = /** @class */ (function () {
    function Liaction() {
    }
    return Liaction;
}());
//# sourceMappingURL=out.js.map
```
```
PS C:\Users\mingm\Desktop\ts> tsc
Active code page: 65001
PS C:\Users\mingm\Desktop\ts>
```

es6如下
```
class Control {
}
// 定义一个子类，该类继承自Control,并使用接口SelectableControl，由于是子类，可以使用SelectableControl接口
class Button extends Control {
    select() { }
    ;
}
// 定义一个子类该类继承自Control
class TextBox extends Control {
    select() { }
}
// 定义一个Image类，该类不能使用SelectableControl接口
//class Image implements SelectableControl{
//}
// 和其余类没有任何继承关系的类
class Liaction {
}
//# sourceMappingURL=out.js.map
```
