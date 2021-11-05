pipeline {
agent any
  stages {
    stage('fetch_latest_code') {
      steps {
        git url: 'https://github.com/orleonbatista/vorx-jenkins.git', branch: 'main'
      }
    }

    stage('TF Init&Plan') {
      steps {
        script {
          sh 'terraform init'
          sh 'terraform plan -out=myplan.out'
        }
      }
    }

    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Deseja realizar alteracoes na Infraestrutura?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply no Terraform', name: 'Confirmar'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
          sh 'terraform apply myplan.out'
      }
    }
  }
}