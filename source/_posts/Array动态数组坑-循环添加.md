title: 'Array动态数组坑 循环添加 '
author: Ming ming
tags: []
categories:
  - 后端
  - java
  - 坑集合
date: 2018-12-21 17:28:00
---
Array动态数组坑 循环添加 

# 问题
```
/**  
 * @param limt  
  * @param length  
  * @return List<Student>  
 * 返回学生列表,第一个参数为页数  第二个参数为页数的长度，返回的是已经分页过的  
  */  
public List<Student> listStudent(int limt, int length) throws Exception {  
    // 验证传入值  
  if(limt < 0 || length < 0){  
        throw new Exception("传入的limt，length错误");  
    }  
    // 拼接sql  
  this.sql = "SELECT sno,sn,sex,age,dept FROM s LIMIT " + limt * length + "," + length + ";";  
    // 执行sql  
  super.executeQuery();  
    // 获取结果  
  ResultSet rs = this.getResultSet();  
    List<Student> list = new ArrayList<Student>();  
    Student tmpStudent = new Student();
    while(rs.next()){    
        //System.out.println(rs.getString(1));  
  tmpStudent.setSno(rs.getString(1));  
        tmpStudent.setSn(rs.getString(2));  
        tmpStudent.setSex(rs.getString(3));  
        tmpStudent.setAge(rs.getString(4));  
        tmpStudent.setDept(rs.getString(5));  
        //System.out.println(tmpStudent.getSno());  
  list.add(tmpStudent);  
    }  
    return list;  
}
```
上方一个类的一个方法。但是输出的结果为一个常值。
结果如下
```
SnapShooter listening on port 34927
0780506004
0780506004
0780506004

Process finished with exit code 0
```
输出的是三个常值，为什么呢

# 原因
没能力看懂源码，翻书，书上说动态数组在存储位置上存储这对象的引用，即，存放的是指针，指向内存区域，所以如果每次不new一块新的内存地址，等于每次修改的都是同一块内存地址。
第一次循环，对刚刚new出的内存中的对象进行修改，第二次循环，数组的第二个项指针指向同一块内存地址，对同一块内存地址进行再次修改，第三次依旧，所以三次使用的都是对同一块内存地址的引用。
至此，就能解释为什么三次输出的是同一个值。

# 解决
当然每次循环都new出一块内存，用于保存数据。
修改如下
```
public List<Student> listStudent(int limt, int length) throws Exception {  
    // 验证传入值  
  if(limt < 0 || length < 0){  
        throw new Exception("传入的limt，length错误");  
    }  
    // 拼接sql  
  this.sql = "SELECT sno,sn,sex,age,dept FROM s LIMIT " + limt * length + "," + length + ";";  
    // 执行sql  
  super.executeQuery();  
    // 获取结果  
  ResultSet rs = this.getResultSet();  
    List<Student> list = new ArrayList<Student>();  
    while(rs.next()){  
        Student tmpStudent = new Student();  
        //System.out.println(rs.getString(1));  
  tmpStudent.setSno(rs.getString(1));  
        tmpStudent.setSn(rs.getString(2));  
        tmpStudent.setSex(rs.getString(3));  
        tmpStudent.setAge(rs.getString(4));  
        tmpStudent.setDept(rs.getString(5));  
        //System.out.println(tmpStudent.getSno());  
  list.add(tmpStudent);  
    }  
    return list;  
}
```