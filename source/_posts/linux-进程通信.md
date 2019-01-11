title: linux 进程通信
author: Ming ming
tags: []
categories:
  - 基础知识
  - C++
  - ''
date: 2018-12-17 11:31:00
---
linux 进程通信

这里实现最简单的管道通信
```
#include <iostream>  
#include <unistd.h>  
#include <sys/stat.h>  
#include <sys/types.h>  
#include <sys/wait.h>  
#include <sys/param.h>  
  
int main(){  
    int fd[2];  
  ssize_t n;  
  pid_t pid;  
  char buffer[BUFSIZ + 1];  
  pipe(fd); // 创建管道  
  pid = fork(); // 从这里创建子进程  
  if (pid > 0){  
        // 这里是父进程  
  close(fd[0]); // 关闭读  
  write(fd[1], "hello world", 12);  
  }  
    else{  
        // 这里是子进程  
  close(fd[1]);  
  n = read(fd[0], buffer, BUFSIZ); // 创建读  
  std::cout << buffer << std::endl;  
  }  
  
}
```


