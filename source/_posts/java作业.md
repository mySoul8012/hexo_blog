title: java作业
author: Ming ming
tags: []
categories:
  - 后端
  - Java
date: 2018-10-08 00:41:00
---
Java 判断年份是否为闰年
> 下面都是一些较为简单的题

```
// 判断年份是否为闰年的问题
import javax.swing.JOptionPane;

public class IfYear {
	public static void main(String [] args) {
		int year;
		String tmp;
		year = Integer.parseInt(JOptionPane.showInputDialog("请输入年份\n"));

		// 判断闰年
		if ((year % 4 == 0 && year % 100 != 100) ||  year % 100 == 0) {
			tmp = "您输入的是闰年";
		} else {
			tmp = "您输入的不是闰年";
		}

		// 输出结果
		JOptionPane.showMessageDialog(null, tmp,"结果", JOptionPane.PLAIN_MESSAGE);
	}
}
```


从键盘输入整数，求出三个数的最大值
```
// 输出三个数中的最大数
import javax.swing.JOptionPane;
public class FindMax {
	public static void main(String[] agrs) {
		int n1, n2, n3;
		int max;
		n1 = Integer.parseInt(JOptionPane.showInputDialog("输入第一个数\n"));
		n2 = Integer.parseInt(JOptionPane.showInputDialog("输入第二个数\n"));
		n3 = Integer.parseInt(JOptionPane.showInputDialog("输入第三个数\n"));
		max = (n1 > n2)?n1:n2;
		max = (max > n3)?max:n3;
		JOptionPane.showMessageDialog(null, "输出最大的结果是" + max, "结果", JOptionPane.PLAIN_MESSAGE);
	
	}
}
```


从键盘输入整数，对三个数进行排序，使用冒泡
```
// 三个数从大到小排列
import javax.swing.JOptionPane;
public class FindThreeNumber {
	public static void main(String[] args) {
		int[] number = new int[3];	// 声明数组
		int i, j, tmp;
		// 读取数据
		for(i = 0; i < 3; i++) {
			number[i] = Integer.parseInt(JOptionPane.showInputDialog("请输入第" + (i + 1) + "数"));
		}
		// 进行冒泡
		for(i = 0; i < 3-1; i++) {
			for (j = 0; j < 3 - i - 1; j++) {
				if (number[j] <= number[j + 1]) {
					tmp = number[j];
					number[j] = number[j + 1];
					number[j + 1] = tmp;
				};
			};
		};
		JOptionPane.showMessageDialog(null, number[0] + ">" + number[1] + ">" + number[2], "结果", JOptionPane.PLAIN_MESSAGE);
	}
}
```

> 使用冒泡算法对三个数进行排序

> 声明数组的时候，需要先声明数组变量，才能在程序中使用数组，[]在后方是来自于C/C++的语法, 方括号在前方为来自面向对象的语法
