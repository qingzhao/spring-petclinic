node('jnlp-slave') {
  stage('Prepare') {
	git ' https://github.com/qingzhao/spring-petclinic.git '
  }
  

   stage('get token'){
       sh 'exec ./api.sh'
   }
}