pipeline {
  agent any
stages{
    stage('Deploy_Artifact_to_autoscale_group') {
      steps {
        node('Ansible'){
         checkout scm
         ansiblePlaybook playbook: '$WORKSPACE/autoscale_ec2.yaml'
      }
      }}
  }
  }
