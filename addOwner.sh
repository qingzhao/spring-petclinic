token=$(cat ./token.file)
id=$(cat ./service_id.txt)


check_service_status(){
curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/microservices/$id"|python2 -m json.tool | grep "status"| awk -F":|," '{print $2}'  >status.txt 

}





