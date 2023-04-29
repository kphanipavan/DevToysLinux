pipeline {
  agent any
  stages {
    stage('error') {
      steps {
        sh 'su - bread -c "/home/bread/Applications/bin/flutter build"'
      }
    }

  }
}