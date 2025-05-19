pipeline {
    agent any

    environment {
        DOCKER_HUB_USERNAME = 'krtech26'
        DEV_IMAGE = 'react-site-app-dev'
        PROD_IMAGE = 'react-site-app-prod'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    def branchName = env.GIT_BRANCH
                    if (branchName == 'origin/dev') {
                        git branch: 'dev', url: 'https://github.com/kamal261292/project.git'
                    } else if (branchName == 'origin/main') {
                        git branch: 'main', url: 'https://github.com/kamal261292/project.git'
                    }
                }
            }
        }

        stage('DockerHub Credentials') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker-hub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    echo "DockerHub credentials loaded"
                }
            }
        }

        stage('Build Docker Image') {
            when { expression { env.GIT_BRANCH == 'origin/dev' } }
            steps {
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Push Docker Image to Dev') {
            when { expression { env.GIT_BRANCH == 'origin/dev' } }
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker-hub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_HUB_USERNAME/$DEV_IMAGE:dev
                        docker logout
                    """
                }
            }
        }

        stage('Push Docker Image to Prod') {
            when { expression { env.GIT_BRANCH == 'origin/main' } }
            steps {  
                sh """
                    docker pull ${DOCKER_HUB_USERNAME}/${DEV_IMAGE}:dev
                    docker tag ${DOCKER_HUB_USERNAME}/${DEV_IMAGE}:dev ${DOCKER_HUB_USERNAME}/${PROD_IMAGE}:prod
                    docker push ${DOCKER_HUB_USERNAME}/${PROD_IMAGE}:prod
                    docker rmi ${DOCKER_HUB_USERNAME}/${PROD_IMAGE}:prod
                """
            }
        }
    }
}
