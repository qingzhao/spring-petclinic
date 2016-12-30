token=`curl -X POST -H "Content-Type: application/json" -d '{  "app_key":"8009036ca6d1485d9b6fb2ba5aac0088",  "app_secret":"83cf66576a6b44368f81b2dfeb6a2173"}' "https://open.c.163.com/api/v1/token" | awk -F\" '{print "Authorization: Token "$4}'`

#这个会列出所有镜像仓库中的有效镜像
#curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/microservices/images" | python2 -m json.tool | grep "centos:7.0" -A 4| grep repo_id| awk -F":|," '{print $2}'  >1.txt



repo_id=$(curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/repositories"  | python2 -m json.tool |grep "petclinic2" -C 5  |grep "repo_id" | awk -F":|," '{print $2}')



curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/repositories/$repo_id" |python2 -m json.tool > images.txt

image_status=$(cat images.txt|grep "tags" -A 50| grep "v" -C 2|head -n 5  |grep "status")



if [ "$image_status" = "2" ] ; then
echo status ok
else 
echo status error
fi

#2016-12-07T06:53:04Z 
date_str=`cat images.txt |grep "updated_at" |awk -F "\"" '{print $4}'`

#转化为秒
#date -d $str +%s   


# get namespace                                                                                                                                                                                                                                     
namespaceid=$(curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/namespaces" | python2 -m json.tool| grep -A 2 '"display_name": "jenkins"' | grep id|awk -F"[:,]" '{print $2}' |sed 's/ //g')              
echo "namespace  id is "$namespaceid  

image_path="hub.c.163.com/public/petclinic2:v28"

curl -X POST -H "Content-Type: application/json" -H "$token" -d "\                                                                                                                                                                                  
        {\                                                                                                                                                                                                                                          
                \"bill_info\":\"default\",\                                                                                                                                                                                                         
                \"service_info\":\                                                                                                                                                                                                                  
                        {\                                                                                                                                                                                                                          
                                \"namespace_id\":$namespaceid,\                                                                                                                                                                                     
                                \"service_name\":\"myservice\",\                                                                                                                                                                                    
                                \"spec_id\":1,\                                                                                                                                                                                                     
                                \"replicas\":1,\                                                                                                                                                                                                    
                                \"port_maps\":[\                                                                                                                                                                                                    
                                        {\                                                                                                                                                                                                          
                                                \"source_port\":80,\                                                                                                                                                                                
                                                \"dest_port\":80,\                                                                                                                                                                                  
                                                \"protocol\":\"TCP\"\                                                                                                                                                                               
                                        }\                                                                                                                                                                                                          
                                ],\                                                                                                                                                                                                                 
                                \"stateful\":0,\                                                                                                                                                                                                    
                                \"state_public_net\":{\                                                                                                                                                                                             
                                   \"used\": false,\                                                                                                                                                                                                
                                   \"type\": \"bandwidth\"\                                                                                                                                                                                         
                                            },\                                                                                                                                                                                                     
                                \"disk_type\":2\                                                                                                                                                                                                    
                        },\                                                                                                                                                                                                                         
                \"service_container_infos\":[\                                                                                                                                                                                                      
                        {\                                                                                                                                                                                                                          
                                \"container_name\":\"mycontainer\",\                                                                                                                                                                                
                                \"image_path\":\"hub.c.163.com/public/centos:7.0\",\                                                                                                                                                                
                                \"cpu_weight\":100,\                                                                                                                                                                                                
                                \"memory_weight\":100\                                                                                                                                                                                              
                        }\                                                                                                                                                                                                                          
                ]\                                                                                                                                                                                                                                  
        }\                                                                                                                                                                                                                                          
" "https://open.c.163.com/api/v1/microservices"             