pipeline {

  options {
    ansiColor('xterm')
  }

  agent {
    kubernetes {
      yamlFile 'builder.yaml'
    }
  }

  stages {

    stage('Kaniko Build & Push Image') {
      steps {
        container('kaniko') {
          script {
            sh '''
            /kaniko/executor --dockerfile `pwd`/Dockerfile \
                             --context `pwd` \
                             --destination=alexfersh/alpine-k8s:${BUILD_NUMBER} \
                             --destination=alexfersh/alpine-k8s:latest \
                             --cleanup
            '''
          }
        }
      }
    }
  
  }
}