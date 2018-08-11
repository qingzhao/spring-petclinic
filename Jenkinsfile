node('master') {
  stage('Prepare') {
      sh "rm spring-petclinic -rf"    
      sh "git clone https://github.com/qingzhao/spring-petclinic.git"
	
  }
  

   stage('get token'){
       sh 'chmod +x ./spring-petclinic/getToken.sh'
       sh 'exec ./spring-petclinic/getToken.sh'
   }

   stage('check images'){
       sh 'chmod +x ./spring-petclinic/check_images.sh'
       sh 'exec ./spring-petclinic/check_images.sh'
   }
   stage('create service'){
       sh 'chmod +x ./spring-petclinic/create_service.sh'
       sh 'exec ./spring-petclinic/create_service.sh'
   }
   stage('unit test'){
      sh  "apt-get update && apt-get install -y wget"
      sh  "wget  http://zqz-b1.nos-eastchina1.126.net/settings.xml && cp settings.xml /root/.m2/settings.xml"
      sh "cd spring-petclinic && mvn -PMySQL test"
   }
   stage('check service'){
       sh 'chmod +x ./spring-petclinic/check_service.sh'
       sh 'exec ./spring-petclinic/check_service.sh'
   }
   stage('test'){
       sh 'chmod +x ./spring-petclinic/addOwner.sh'
       sh 'exec ./spring-petclinic/addOwner.sh'
   }
   stage('clean service'){
   }
}
