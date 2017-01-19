token=$(cat ./token.file)
currenttime=`date +%s`

checkCount=30

repo_id=$(curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/repositories"  | python2 -m json.tool |grep "ci_test" -C 5  |grep "repo_id" | awk -F":|," '{print $2}')                                                                                                

check_status(){
	#image_status=$(cat images.txt|grep "tags" -A 50|head -n 5  |grep "status")                                                                                                     
        image_status=$(cat images.txt|grep "tags" -A 50|head -n 5|grep name|awk -F '"' '{print $4}')
	if [ "$image_status" = "2" ] ; then
		echo status ok
		exit 0
	else
		echo status error
		exit 1
	fi
}

compare_time(){

	if [ $1 -ge $2 ]; then
		#echo "$1 >= $2"
		echo 0
	else
		#echo "$1 < $2"
		echo 1
	fi

}
check_time(){

	curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/repositories/$repo_id" |python2 -m json.tool > images.txt                                                      

	branch=master
	length=${#branch}


	name=$(cat images.txt|grep "tags" -A 50|head -n 5|grep name|awk -F '"' '{print $4}')
	timestr=${name:$length}

	secondstr=${timestr::14}
	time1=$(date -d $secondstr +%s)

#20161230054238

	formatstr=${secondstr::4}'-'${secondstr:4:2}'-'${secondstr:6:2}' '${secondstr:8:2}':'${secondstr:10:2}':'${secondstr:12:2}

	buildtime=$(date -d "$formatstr" +%s)

	ret=`compare_time $buildtime $currenttime`
        echo $ret
}



check(){

	ret=`check_time`
	count=1
	while [ $ret -ne 0 ]
	do

		if [ $count -gt $checkCount ] ;then
			echo "check images $checkCount times. now exit... "
			exit 1
		fi

		sleep 1m
		ret=`check_time`
		count=$[count+1]

	done

	check_status

}
check
