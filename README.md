# PCH
对iOS项目中PCH文件的创建、配置以及使用做了详细的介绍

**简书文章地址：[02_@class与#import](http://www.jianshu.com/p/040ae79f9fda)**

### 预览

![Alt text](https://github.com/XiaoSongWolf/PCH/raw/master/PCHDemo.gif)

**PCH文件：预编译头文件(一般扩展名为.PCH)，是把一个工程中较稳定的代码预先编译好放在一个文件(.PCH)里。这些预先编译好的代码可以是任何的C/C++代码--甚至可以是inline函数，只是它们在整个工程中是较为稳定的，即在工程开发过程中不会经常被修改的代码。**

#### 1、PCH文件的创建

1、打开新建文件页面，在Other里面选择PCH File，点击Next；     
2、输入PCH文件名，一般输入工程名，点击create，PCH文件创建成功。    
![Alt text](https://github.com/XiaoSongWolf/PCH/raw/master/创建PCH文件.jpeg)

#### 2、配置PCH文件

1、打开工程配置，选择Build Settings；  
2、在搜索框输入Prefix Header，左侧选择All，回车；  
3、选中Prefix Header，在其后面的空白处双击；  
4、在弹出的小框内输入配置路径，格式是：$(SRCROOT)/项目名/PCH文件名。  
注意：输入PCH文件时不能省略后缀名。  
![Alt text](https://github.com/XiaoSongWolf/PCH/raw/master/PCH文件配置.jpeg)
