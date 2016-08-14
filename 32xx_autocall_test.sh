#./Script [Video?] [Phone] [DTMF?], Support 32xx, Written by pcxu@grandstream.com 2013/12/26
#E.g:
#./Script 10086 ,Audio call
#./Script 1 10086 ,Video call
if [ $# -eq 1 ];then
	type=0;phone=$1
elif [ $# -eq 2 ];then
	type=$1;phone=$2
elif [ $# -eq 3 ];then
	type=$1;phone=$2;dtfm=$3
else
	echo "Error options, please check!" && exit
fi
product=`cat /proc/gxvboard/dev_info/dev_id | grep 3240` #3240/3275
products=$?;r=1;log=$(basename $0)".log"
t=1
while [ 1 ];do
	input keyevent 4 && am start -a android.intent.action.DIAL -d tel:$phone && sleep 1
	echo "Script: Dial phonenumber "$phone"("$t")" && sleep 1
	echo "Script: Runtime => "$r >> $log
	if [ $products -eq 1 ];then #3275
		if [ $type -eq 1 ];then input tap 951 500 && sleep 1 && input tap 951 500;else input tap 951 328;fi #Audiocall/Videocall
		#sleep 12 && input tap 615 19 && input tap 691 570 #open keybroad
		#if [ $# -eq 3 ];then input text $3;else input text 123;fi
		sleep 30 && screenshot && sleep 30 && input tap 960 567 && sleep 2 && input tap 960 567
	else #3240
		if [ $type -eq 1 ];then input tap 278 115;else input tap 278 54;fi
		sleep 12
		#if [ $# -eq 3 ];then input text $3;else input text 123;fi
		screenshot && input tap 211 215 && sleep 30 && input tap 211 215 && sleep 2 && input tap 211 215 
	fi
	echo "Script: Dial phonenumber ("$t")" && sleep 1
	sleep 1
	let t=t+1
done
