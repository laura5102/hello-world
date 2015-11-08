#!/usr/bin/env python
# -*- coding:utf-8 -*-  

#hello 函数，需要youname 参数，返回字符串
def hello(youname):
	return "Hello, %s"%(youname,)

#如果该脚本独立运行
if __name__ == "__main__":
	print "What's you name?"    #输出一个字符串，询问名称
	youname = raw_input("my name is: ")    #捕捉用户输入，并保存到youname变量中
	so_i_say = hello(youname)    #将用户输入作为参数，调用hello函数，并将返回值保存到so_i_say变量中
	print so_i_say    #打印 so_i_say
