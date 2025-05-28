pipeline {
    // Kubernetes agent with direct access to kubernetes cluster using a service account
    // agent {
    //     kubernetes {
    //         serviceAccount 'jenkins'
    //         containerTemplate {
    //             name 'shell'
    //             image 'registry.digitalocean.com/hxyro-test/jenkins'
    //             command 'sleep'
    //             args 'infinity'
    //         }
    //     }
    // }
    agent any

    environment {
        DOC_REGISTRY                = "registry.digitalocean.com/hxyro-test"
        IMAGE_NAME                  = "flask-backend"
        APP_NAME                    = "flask-backend" // Used for deployment
        HEALTHCHECK_PATH            = "https://app.indiaone.io/health" // Path for health check
        NAMESPACE                   = 'prod'
        KUSTOMIZE_PATH              = 'kustomize'
        DOC_REGISTRY_CREDENTIALS_ID = "doc-registry-credentials" // Jenkins credentials for Docker registry
        KUBECONFIG_ID               = "kubeconfig-creds"  // Jenkins credentials for kubeconfig
    }

    stages {
        stage('Prepare Build Environment') {
            steps {
                script {
                    echo "Initializing build environment..."
                    env.REGISTRY = env.DOC_REGISTRY.split('/')[0] // Extract registry host from the full ID
                    env.IMAGE = "${env.DOC_REGISTRY}/${env.IMAGE_NAME}"
                    env.FULL_IMAGE = "${env.IMAGE}:${env.BUILD_ID}" // Full image name with tag
                    echo "Pipeline Configuration:"
                    echo "  Registry: ${env.REGISTRY}"
                    echo "  Image: ${env.FULL_IMAGE}"
                    echo "  Kustomize Path: ${env.KUSTOMIZE_PATH}"
                    echo "  Kubernetes Namespace: ${env.NAMESPACE}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${env.IMAGE}"
                    docker.build(env.FULL_IMAGE, ".")
                }
            }
        }

        stage('Login and Push to DigitalOcean Registry') {
            steps {
                script {
                    echo "Logging in to ${env.REGISTRY} and pushing image ${env.FULL_IMAGE} 🚀"
                    docker.withRegistry("https://${env.REGISTRY}", env.DOC_REGISTRY_CREDENTIALS_ID) {
                        docker.image(env.FULL_IMAGE).push()
                    }
                    echo "Image pushed successfully: ${env.FULL_IMAGE}"
                }
            }
        }

        stage('Kustomize Edit Image Tag') {
            steps {
                dir(env.KUSTOMIZE_PATH) { // Change working directory to where kustomization.yaml is located
                    script {
                        echo "Updating kustomization in '${pwd()}' with image '${env.FULL_IMAGE}'"

                        // This command updates the image tag in kustomization.yaml.
                        sh "kustomize edit set image ${env.IMAGE}=${env.FULL_IMAGE}"

                        echo "Kustomization updated. Verifying kustomization.yaml content (first 15 lines):"
                        sh "cat kustomization.yaml | head -n 15 || echo 'Warning: kustomization.yaml not found or cat command failed in ${pwd()}'"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo "Deploying application to namespace '${env.NAMESPACE}' using kustomization from '${env.KUSTOMIZE_PATH}' via kubectl..."
                    withKubeConfig([kubeconfigId: env.KUBECONFIG_ID]) {
                        sh "kubectl apply -k ${env.KUSTOMIZE_PATH} --namespace ${env.NAMESPACE}"
                        echo "Verifying deployment rollout status for 'deployment/${env.APP_NAME}' in namespace '${env.NAMESPACE}'..."
                        sh "kubectl rollout status deployment/${env.APP_NAME} --namespace ${env.NAMESPACE} --timeout=5m" // 5 minute timeout
                        echo "Deployment rollout monitoring finished for 'deployment/${env.APP_NAME}'."
                    }
                }
            }
        }

        stage('Verify Application Health') {
            steps {
                script {
                    echo "Verifying application health at ${env.HEALTHCHECK_PATH} in namespace '${env.NAMESPACE}'..."
                    sh "curl -f --connect-timeout 10 --max-time 30 ${env.HEALTHCHECK_PATH}"
                }
            }
        }
    }

    post {
        success {
            script {
                echo "Pipeline completed successfully! 🎉"
            }
        }
        failure {
            script {
                echo "Pipeline failed. 😥 Check console output for details."
            }
        }
    }
}