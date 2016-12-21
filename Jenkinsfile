node('jnlp-slave') {
  stage('Prepare') {
      sh "rm spring-petclinic -r"    
      sh "git clone https://github.com/qingzhao/spring-petclinic.git"
	
  }
  

   stage('get token'){
       sh 'exec ./spring-petclinic/api.sh'
   }
}