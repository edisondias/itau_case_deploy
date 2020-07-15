
pipeline {
  agent any

  stages {
    stage('Build') {
        steps {
          withCredentials([
            usernamePassword(credentialsId: 'rqwef1054wdd0gnv304lmt51rbjd0y', passwordVariable: 'AWS_SECRET', usernameVariable: 'AWS_KEY')
          ]) {
            sh 'packer build -var aws_access_key=${AWS_KEY} -var aws_secret_key=${AWS_SECRET} packer/edias.json'
        }
      }
    }
    stage('Deploy') {
      steps {
          withCredentials([
            usernamePassword(credentialsId: 'rqwef1054wdd0gnv304lmt51rbjd0y', passwordVariable: 'AWS_SECRET', usernameVariable: 'AWS_KEY'),
          ]) {
            sh '''
               cd terraform
               terraform init
               terraform apply -auto-approve -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
            '''
        }
      }
    }
  }
}