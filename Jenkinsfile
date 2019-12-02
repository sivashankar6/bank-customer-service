pipeline {
  agent any
  tools { 
       //maven 'Maven'
        jdk 'JAVA_HOME'
  }
  stages {
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace... */
      steps {
        checkout scm
      }
    }
   stage('Build') {
        def mvn_version = 'Maven'
        withEnv( ["PATH+MAVEN=${tool mvn_version}/bin"] ) {
        sh '''for f in i7j-*; do
                (cd $f && mvn clean package -Dmaven.test.skip=true -Dadditionalparam=-Xdoclint:none  | tee ../jel-mvn-$f.log) &
              done
              wait'''
        }
   } 
    stage('Docker Build') {
      steps {
        sh '/usr/bin/docker build -t satheeshch/bank-customer-service:latest .'
      }
    }
    stage('Push image') {
      steps {
        withDockerRegistry([credentialsId: 'docker-hub', url: "https://index.docker.io/v1/"]) {
          sh '/usr/bin/docker push satheeshch/bank-customer-service:latest'
        }
      }
    }
  }
}
