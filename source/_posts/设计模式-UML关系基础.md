title: 设计模式-UML关系基础
author: Ming ming
tags: []
categories:
  - 基础知识
  - 设计模式
date: 2018-11-08 16:59:00
---
设计模式-UML关系基础
UML关系基础
# 类之间的关系
## 泛化
类在继承中表现为泛化和实现。
继承关系为is-a的关系，两个对象之间用is-a表示为继承关系。
eg，自行车是车，猫是动物。
泛化关系用空心箭头表示
如下图。
A继承自B
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/11/09/1.png)

用空心箭头表示A继承自B
泛化关系表示为继承抽象类。
> 抽象类可以继承一个具体的类的。
> 抽象类可以被实体类继承
> 抽象类可以被其他抽象类继承

## 实现关系
实现关系用空心箭头表示。
即指向C++中的抽象类（通过纯虚函数实现），java中的接口，表示实现关系。
> 即，无法直接定义对象的都被成为抽象类。
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/11/09/2.png)

即，在上方中A继承自抽象类B
## 聚合关系
用带空心的菱形箭头的直线表示
A聚合到B上，B由A组成。
聚合关系表示实体对象之间的关系，表示整体由部分构成的语义。
> 一个部门由多个员工组成。为聚合关系。

与组合关系的区别，不是强依赖关系。即使整体不存在，部分依旧存在。
部门撤销，人员不会消失，依旧存在。

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/11/09/3.png)

## 组合关系
组合关系用带实心的菱形箭头表示。
A组成B，B由A组成。
组合关系强调强依赖的聚合关系。
整体不存在，则部分也将不存在。
公司不存在，那么部门也将不存在。
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/11/09/4.png)


## 关联关系
关联关系用一条直线表示，描述不同类的对象之间的结构关系。
一种静态关系。
通常与运行状态无关。
用于定义对象之间，天然的，静态的结构。
乘车人和车票属于关联关系，学生和学校属于关联关系。
关联关系默认不强调方向。如果强调方向，则A知道B，但是B不知道A

![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/11/09/5.png)

用成员变量来实现

## 依赖关系
用带箭头的虚线表示两者之间的依赖关系。
A依赖B，描述一个对象在运行期间会用到另外一个对象的关系。
依赖关系体现在类的构造方法，以及类的方法的传入参数。箭头指向为调用关系。
依赖关系能让对象知道，还能使用对方的方法和属性。
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/blog-image/2018/11/09/6.png)



# 时序图
展示对象之间的交互细节，使用时序图。
时序图有对象，生命线，控制焦点，消息。
![](https://melovemingming-1253878077.cos.ap-chengdu.myqcloud.com/wx.png)
www.iming.info