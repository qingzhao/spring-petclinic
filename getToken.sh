token=`curl -X POST -H "Content-Type: application/json" -d '{  "app_key":"953b3284ada84102ae014ec1baf097b4",  "app_secret":"8e8cea4ac81a42ae8f88eca1884f50b2"}' "https://open.c.163.com/api/v1/token" | awk -F\" '{print "Authorization: Token "$4}'`

curl -X GET -H "Content-Type: application/json" -H "Authorization: Token 5fa6ba5cbba24d92a48990e8bfb09814" "https://open.c.163.com/api/v1/microservices/images" | python2 -m json.tool | grep "centos:7.0" -A 4| grep repo_id| awk -F":|," '{print $2}'  >1.txt

#curl -X GET -H "Content-Type: application/json" -H "Authorization: Token 5fa6ba5cbba24d92a48990e8bfb09814" "https://open.c.163.com/api/v1/namespaces"

curl -X GET -H "Content-Type: application/json" -H "Authorization: Token 5fa6ba5cbba24d92a48990e8bfb09814" "https://open.c.163.com/api/v1/namespaces/34685/microservices?offset=0&limit=100"


curl -X GET -H "Content-Type: application/json" -H "Authorization: Token 5fa6ba5cbba24d92a48990e8bfb09814" "https://open.c.163.com/api/v1/microservices/48718"


#containerId 48718
#hub.c.163.com/library/jenkins:latest

curl -X PUT -H "Content-Type: application/json" -H "Authorization: Token 5fa6ba5cbba24d92a48990e8bfb09814" -d '{"min_ready_seconds": 11,"container_images": [{"container_id":48718,"image_path":"hub.c.163.com/library/jenkins:latest"}]}' "https://open.c.163.com/api/v1/microservices/48718/actions/update-image"


curl -X POST -H "Content-Type: application/json" -H "Authorization: Token 5fa6ba5cbba24d92a48990e8bfb09814" -d '{"service_info":{"namespace_id":34685,"service_name":"myservice","spec_id":1,"replicas":1,"port_maps":[{"source_port":80,"dest_port":8080,"protocol":"TCP"}],"stateful":0,"disk_type":1},"service_container_infos":[{"container_name":"mycontainer","container_desc":"res","image_path":"hub.c.163.com/public/centos:7.0","cpu_weight":100,"memory_weight":100}]}' "https://open.c.163.com/api/v1/microservices"



#953b3284ada84102ae014ec1baf097b4 8e8cea4ac81a42ae8f88eca1884f50b2
