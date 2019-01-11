title: TypeScript 函数
author: Ming ming
date: 2018-10-30 23:50:01
tags:
---
TypeScript 函数
# 函数类型
为函数定义类型
```
function add(x: number, y:number):number{
	return x + y;
}

let myAdd = function(x:number, y:number):number{
	return x + y;
}
```
使用这种方式，为函数定义返回的类型
```
function add(x, y) {
    return x + y;
}
var myAdd = function (x, y) {
    return x + y;
};
//# sourceMappingURL=out.js.map
```
# 书写函数类型
```
let myAdd: (baseValue: number, increment:number)=>number = 
	function(baseValue: number, increment: number): number {
		return baseValue + increment;
}
```
书写函数类型，代表形参为baseValue和increment两个都为number类型，返回的也同样为number类型。
# 推断类型
```
// 赋值语句一边有类型，而另外的一边没有类型，此时会自动识别出类型
let myAdd = function(x:number, y:number):number{
	return x + y;
}

let myAdd1:(baseValue: number, increment:number) => number =
function(x,y){
	return x + y;
}
```
会自动推断出类型

# 可选参数 默认参数
不能传递null和undefined作为参数。
```
// 可选参数 使用？
function buildName(firstName:string, lastName?:string){
	if (lastName)
		return firstName + " " + lastName;
	else
		return firstName;
}

let result1 = buildName("Bob");
let result2 = buildName("bod", "adams");
```
# 剩余参数
```
function buildName(firstName:string, ...restOfName:string[]){
	return firstName + " " + restOfName.join(" ");	// 进行字符串的拼接
}

let employeeName = buildName("Joseph", "Samuel", "Lucas");
```
```
function buildName(firstName) {
    var restOfName = [];
    for (var _i = 1; _i < arguments.length; _i++) {
        restOfName[_i - 1] = arguments[_i];
    }
    return firstName + " " + restOfName.join(" "); // 进行字符串的拼接
}
var employeeName = buildName("Joseph", "Samuel", "Lucas");
//# sourceMappingURL=out.js.map
```
# this 箭头函数保存创建时调用的
```
// 箭头函数能保存函数创建时的this的值，不是调用值
let deck = {
	suits: ["hearts", "spades", "clubs", "diamonds"],
	cards:Array(52),
	createCardPicker:function(){
		return ()=>{
			let pickedCard = Math.floor(Math.random() * 52);
			let pickedSuit = Math.floor(pickedCard / 13);

			return { suit: this.suits[pickedSuit], card: pickedCard % 13 };
		}
	}
}

```
# 重载
```
function pickCard(x):any {
	if (typeof x == "object"){
		let pickedCard = Math.floor(Math.random());
		return pickedCard;
	}
	else if (typeof x == "number"){
		let pickedSuit = Math.floor(x);
		return { x: x };
	}
}
```
使用if语句即可
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/wx.png)
