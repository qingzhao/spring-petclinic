node('jnlp-slave') {
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
   stage('test'){
       sh 'chmod +x ./spring-petclinic/addOwner.sh'
       sh 'exec ./spring-petclinic/addOwner.sh'
   }
}