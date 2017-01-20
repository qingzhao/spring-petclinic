token=$(cat ./token.file)
id=$(cat ./service_id.txt)


check_service_status(){
curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/microservices/$id"|python2 -m json.tool | grep "status"| awk -F":|," '{print $2}'  >status.txt 

   service_status=$(cat status.txt)
	if [ "$service_status" = "create_succ" ] ; then
		echo 0
	else
		exit 1
	fi

}

check(){

	ret=`check_service_status`

	count=1
	while [ $ret -ne 0 ]
	do

		if [ $count -gt $checkCount ] ;then
			echo "check service $checkCount times. now exit... "
			exit 1
		fi

		sleep 1m
		ret=`check_service_status`
		count=$[count+1]

	done

	#check_status

}

check 





