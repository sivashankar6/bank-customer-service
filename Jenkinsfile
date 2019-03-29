pipeline {
  agent any
  tools { 
        maven 'maven'
  }
  stages {
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace... */
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
      withSonarQubeEnv('sonarqube') {
    sh 'mvn clean test sonar:sonar package'
      nexusPublisher nexusInstanceId: 'nexus', nexusRepositoryId: 'maven_release', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/bank-customer-service_project/bank-customer-service-dev/target/customer-service-0.0.1-SNAPSHOT.jar']], mavenCoordinate: [artifactId: 'spring-boot-starter-parent', groupId: 'org.springframework.boot', packaging: 'jar', version: '2.1.3']]]
}
      // sh 'mvn -B -DskipTests clean package'
             }
    }
    stage('CreateInstance') {
      steps {
        node('Ansible'){
         checkout scm
         ansiblePlaybook playbook: '$WORKSPACE/createInstance.yaml'
      }
      }}
    stage('DeployArtifact') {
      steps {
        node('Ansible'){
          withMaven(maven: 'maven') {
          sh 'mvn clean package -DskipTests'
          }
       ansiblePlaybook become: true, colorized: true, credentialsId: 'windows', disableHostKeyChecking: true, inventory: '/tmp/hosts_dev', playbook: 'deployArtifact.yaml'
        
        }}
   }

  }
}
