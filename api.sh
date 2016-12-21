token=`curl -X POST -H "Content-Type: application/json" -d '{  "app_key":"8009036ca6d1485d9b6fb2ba5aac0088",  "app_secret":"83cf66576a6b44368f81b2dfeb6a2173"}' "https://open.c.163.com/api/v1/token" | awk -F\" '{print "Authorization: Token "$4}'`

curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/microservices/images" | python2 -m json.tool | grep "centos:7.0" -A 4| grep repo_id| awk -F":|," '{print $2}'
