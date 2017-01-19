token=$(cat ./token.file)
namespaceid=$(curl -X GET -H "Content-Type: application/json" -H "$token" "https://open.c.163.com/api/v1/namespaces" | python -m json.tool| grep -A 2 '"display_name": "jenkins"' | grep id|awk -F"[:,]" '{print $2}' |sed 's/ //g')
echo "namespace  id is :"$namespaceid
curl -X POST -H "Content-Type: application/json" -H "$token" -d '
        {
                "bill_info":"default",
                "service_info":
                        {
                                "namespace_id":'$namespaceid',
                                "service_name":"myservice",
                                "spec_id":1,
                                "replicas":1,
                                "port_maps":[
                                        {
                                                "source_port":80,
                                                "dest_port":80,
                                                "protocol":"TCP"
                                        }
                                ],
                                "stateful":0,
                                "state_public_net":{
                                        "used":false,
                                        "type":"bandwidth",
                                        "bandwidth":10
                                },
                                "disk_type":2
                        },
                "service_container_infos":[
                        {
                                "container_name":"mycontainer",
                                "image_path":"hub.c.163.com/zhengqingzhao/petclinic2:v28",
                                "cpu_weight":100,
                                "memory_weight":100,
                                "volume_info":{},
                                "local_disk_info":[]
                        }
                ]
        }
' "https://open.c.163.com/api/v1/microservices"|awk -F'"' '{print $4}' > service_id.txt
