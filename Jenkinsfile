pipeline {
    // Assumes Jenkins is configured with Docker, kubectl and kustomize tools
    agent {
        kubernetes {
            serviceAccount 'jenkins'
            containerTemplate {
                name 'shell'
                image 'registry.digitalocean.com/hxyro-test/jenkins'
                command 'sleep'
                args 'infinity'
            }
        }
    }

    environment {
        DOC_REGISTRY   = credentials('DOC_REGISTRY')  // registry.digitalocean.com/hxyro-test
        IMAGE_NAME     = credentials('IMAGE_NAME')       // flask-backend
        NAMESPACE      = 'prod' // Kubernetes namespace to deploy to
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOC_REGISTRY}/${IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }
    }
}
