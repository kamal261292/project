pipeline {
    agent any

    environment {
        DOCKER_HUB_USERNAME = 'krtech26'
        DEV_IMAGE = 'react-site-app-dev'
        PROD_IMAGE = 'react-site-app-prod'
    }

    stages {
        stage('Checkout') {
            when {
            branch 'dev'
            }
            steps {
                git branch: 'dev', url: 'https://github.com/kamal261292/project-01-guvi.git'
            }
        }


        stage('Checkout') {
            when {
            branch 'main'
            }
            steps {
                git branch: 'main', url: 'https://github.com/kamal261292/project-01-guvi.git'
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
            when {
            branch 'dev'
            }
            steps {
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Push Docker Image') {
            when {
                branch 'dev'
            }
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

        stage('push docker image to prod when merge dev to master') {
            when {
            branch 'main'
            }
            steps {  
             sh """
                docker pull ${DOCKER_HUB_USERNAME}/${DEV_IMAGE}:dev
                docker tag ${DOCKER_HUB_USERNAME}/${DEV_IMAGE}:dev ${PROD_IMAGE}:prod
                docker push ${PROD_IMAGE}:prod
                docker rmi ${PROD_IMAGE}:prod
                """
            }
        }
    }
}
