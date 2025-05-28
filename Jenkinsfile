pipeline {
    agent any

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
    }
}
