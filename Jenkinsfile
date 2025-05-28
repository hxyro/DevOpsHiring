pipeline {
    agent any

    environment {
        DOC_REGISTRY = credentials('DOC_REGISTRY')  // registry.digitalocean.com/hxyro-test
        IMAGE_NAME = credentials('IMAGE_NAME')       // flask-app
    }

    stages {
        stage('Run Shell Commands') {
            steps {
                script {
                    sh 'echo "Hello, Jenkins!"'
                    sh 'pwd'
                    sh 'ls -al'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOC_REGISTRY}/${IMAGE_NAME}:${env.BRANCH_NAME}")
                }
            }
        }
    }
}
