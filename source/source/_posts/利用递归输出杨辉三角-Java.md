title: 利用递归输出杨辉三角 Java
author: Ming ming
tags: []
categories:
  - 基础知识
  - 算法
date: 2018-10-17 12:22:00
---
```
// 输出杨辉三角
public class YangHui{
    public static void main(String[] args){
        for(int i = 0; i < 10; i++){
            for(int j = 0;  j <=i; j++){
                System.out.print(eval(i, j) + " ");
            }
            System.out.println("");
        }
    }
    
    public static int eval(int row, int col){
        if(col == 0 || col == row){
            return 1;
        }else {
            return eval(row-1, col-1) + eval(row - 1, col);
        }
    }
}
```
