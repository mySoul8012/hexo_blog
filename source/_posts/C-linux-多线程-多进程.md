title: C++ linux 多线程 多进程
author: Ming ming
tags: []
categories:
  - 基础知识
  - C++
  - ''
date: 2018-12-16 17:02:00
---
C++ linux 多线程 多进程
# 几个名词
进程上下文 即当前代码段中的上下文
进程堆栈 即程序运行时，动态分配的内存空间。
内存信息 即当前进程的内存分配情况
打开的文件描述符，信号控制设置、进程优先级、进程组号、当前工作目录、根目录、资源限制、控制终端
# 多线程
```
#include <iostream>  
#include <cstdlib>  
#include <pthread.h>  
#include <mutex>  
#include <vector>  
#include <zconf.h>  
#include "src/model/tree/Tree.h"  
#include "src/model/HuffmanCoding/HuffmanCoding.h"  
  
  
std::vector<char> vec;  
std::vector<int> vecH;  
std::mutex g_mutex;  
void* runFunction(void *e) {  
    std::string string = "A(B(D(H,I),E(J,)),C(F,G))";  
  std::string find = "A";  
  vecH.push_back(2);  
  vecH.push_back(30);  
  vecH.push_back(20);  
  vecH.push_back(16);  
  //auto Huffman = new HuffmanCoding<char>(vecH);  
  auto tree = new Tree<std::string>(string);  
  tree->LeveLOrder();  
  g_mutex.lock();  
  vec.push_back(tree->findNode('A')->getData());  
  g_mutex.unlock();  
  pthread_exit(NULL);  
}  
  
int main() {  
  
    pthread_t tids[200];  
  for(int i = 0; i < 200; ++i)  
    {  
        int ret = pthread_create(&tids[i], NULL, runFunction, NULL);  
  }  
    for(int i = 0; i < vec.size() ; i++){  
        fork();  
  std::cout << vec[i] << std::endl;  
  }  
    pthread_exit(NULL);  
}
```
上方完成了进程中线程的创建

# 多线程
## fork
fork分支，即，程序运行到此，创建新的进程。
当父进程调用fork()系统调用的时候，该进程陷入内核，由内核态对进程进行复制操作（即将当前的地址在复制一份，复制成一份新的地址空间），
```
#include <iostream>  
#include <unistd.h>  
  
int main() {  
    pid_t pid;  
  std::cout << "hello world" << std::endl;  
  pid = fork();  
  if (pid == -1){  
        std::cout << "fork 失败" << std::endl;  
  }  
    if (pid == 0){  
        std::cout << "这是子进程" << std::endl;  
  }  
    if (pid > 0 ){  
        sleep(2);  
  std::cout << "这是父进程"<< std::endl;  
  }  
    return 0;  
}
```
当返回值为0的时候，代表这是子进程执行的，当返回子为ID号的时候，即当前进程的ID号的时候。
> ps 如果不加sleep的时候，此时父进程先结束，然后子进程成为孤儿进程，托管给init

# 孤儿进程
fork调用后，父子进程交替执行。
> 任何一个进程都要有父进程，init为系统的主进程

此时为孤儿进程

# 守护进程
守护进程，脱离后台，周期的执行某些任务。
即父进程为init的进程成为守护进程
在后台运行，脱离控制终端，禁止进程打开控制终端，
过程 创建子进程，终止父进程，成为孤儿进程
子进程中创建出新会话
更改工作目录
创建文件掩码，即权限
关闭文件描述符
```
#include <iostream>  
#include <unistd.h>  
#include <sys/stat.h>  
#include <sys/param.h>  
  
int main() {  
    pid_t pid;  
  std::cout << "hello world" << std::endl;  
  pid = fork();  
  if (pid == -1){  
        std::cout << "fork 失败" << std::endl;  
  }  
    if (pid == 0){  
        setsid(); // 子进程中创建新的会话  
  chdir("/tmp"); // 改变工作目录为临时 tmp  umask(0); // 设置文件掩码  
  for(int i = 0; i < NOFILE ; i++){  
            close(i);  
  }  
        while(true) {  
            std::cout << "这是子进程" << std::endl;  
  }  
    }  
    if (pid > 0 ){  
        sleep(2);  
  std::cout << "这是父进程"<< std::endl;  
  exit(0);  
  }  
    return 0;  
}
```
# 管道
即使用管道，进程可以实现相互通信。
