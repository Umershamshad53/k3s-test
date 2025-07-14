pipeline {
  agent any

  environment {
    DOCKER_CREDENTIALS = credentials('docker-hub-login')
  }

  stages {
    stage('Build & Push Docker Image') {
      steps {
        script {
          env.port = 3001
          env.tag = "Dev-"

          if (env.BRANCH_NAME == "master") {
            env.tag = ""
            env.port = 3000
          }

          sh """
            docker build -t umershamshad/k3s-test:${tag}latest -t umershamshad/k3s-test:${tag}${BUILD_NUMBER} .
            echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin
            docker push umershamshad/k3s-test:${tag}latest
            docker push umershamshad/k3s-test:${tag}${BUILD_NUMBER}
            sed -i 's|umershamshad/k3s-test:.*|umershamshad/k3s-test:${tag}${BUILD_NUMBER}|' deployment.yaml
            git add deployment.yaml
            git commit -m "Update image tag to ${tag}${BUILD_NUMBER}"
            git push origin HEAD:${BRANCH_NAME}
          """
        }
      }
    }
  }

     post {
    success {
      echo "✅ Deployment successful!"
    }
    failure {
      echo "❌ Deployment failed!"
    }
  }
}
