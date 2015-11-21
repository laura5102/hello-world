#!/bin/bash

#set -x

#临时文件
diffRep="/Users/lei/Documents/DEV/diff.report"
delFile="/Users/lei/Documents/DEV/del.sh"
project="hello-world"


diffCheck()
{
	leftPath=$1
	rightPath=$2
	leftNum=`ls -lR $leftPath|grep -v ".git*"|grep "^-"|wc -l`
	rightNum=`ls -lR $rightPath|grep -v ".git*"|grep "^-"|wc -l`
	diff -r $leftPath $rightPath -x '.git*' -q > $diffRep
        contentIsNot=`cat $diffRep|grep 'differ'|wc -l`
	leftOnly=`cat $diffRep|grep "Only in ${leftPath%%*$project}"|wc -l`
	rightOnly=`cat $diffRep|grep "Only in ${rightPath%%*$project}"|wc -l`
	echo "$1 VS $2, 对比内容如下:"
	echo "* $1 Counts:$leftNum, $2 Counts:$rightNum"
	echo "* differ: $contentIsNot"
	echo "* Only in ${leftPath%%*$project}: $leftOnly"
	echo "* Only in ${rightPath%%*$project}: $rightOnly"
	return 0
}

fileDel()
{	
	dealPath=$1
	echo "现在筛选 $dealPath 存在的文件或目录:"
	echo "${dealPath%%*$project}"
	while read line
	do
    		echo $line|grep "Only in ${dealPath%%*$project}" |grep -v ".git*" | awk '{print $3 $4}' | tee -a  $delFile
	done < $diffRep
	echo "筛选结束"
	echo
	
	sed -i "" "s#:#\/#g" $delFile
	sed -i "" "s#\/\/#\/#g" $delFile
	sed -i "" "s#${dealPath}#rm -rf #g" $delFile
	sed -i "" "/^$/d" $delFile
	return 0
	
}

excDel()
{
	if [ $# == 2 ];then
		chmod 755 $1
		cp -a $1 $2 
		cd $2
		./${1##*\/}
		return 0
	fi	
	return 1
}



if [ $# -lt 2 ];then
        echo "Command Error!"
elif [ $# -gt 2 ];then
        if [ $3 = "-e" ];then
                if [ ! -n $4 ];then
                        echo "Comand broken!"
                else
                        fileDel $4
                        if [ $? -eq 0 ];then
                                echo "文件已生成！"
                        fi
			for i in $@
			do
				if [ $i == "-d" ];then
					excDel $delFile $4
					if [ $? = 0 ];then 
						echo "del success!"
						rm -rf del.sh
					else
						echo "del failed!"
					fi
				fi
			done
                fi
        fi
else
        diffCheck $1 $2
        if [ $? -eq 0 ];then
                echo "对比结束！"
        fi
fi


