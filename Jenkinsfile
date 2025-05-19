pipeline {
    agent any

    environment {
        DOCKER_HUB_USERNAME = 'krtech26'
        DEV_IMAGE = 'react-site-app-dev'
        PROD_IMAGE = 'react-site-app-prod'
    }

    stages {
        stage('Checkout Dev') {
            when {
                branch 'dev'
            }
            steps {
                git branch: 'dev', url: 'https://github.com/kamal261292/project.git'
            }
        }


        stage('Checkout Main') {
            when {
                branch 'main'
            }
            steps {
                git branch: 'main', url: 'https://github.com/kamal261292/project.git'
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
                        docker push $DOCKER_HUB_USERNAME/$DEV_IMAGE:latest
                        docker logout
                    """
                }
            }
        }

        stage('Push Docker Image to Prod on Main') {
            when {
                branch 'main'
            }
<<<<<<< HEAD
            steps {  
             sh """
                docker pull ${DOCKER_HUB_USERNAME}/${DEV_IMAGE}:latest
                docker tag ${DOCKER_HUB_USERNAME}/${DEV_IMAGE}:latest ${PROD_IMAGE}:prod
                docker push ${PROD_IMAGE}:prod
                docker rmi ${PROD_IMAGE}:prod
=======
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker-hub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                sh """
                    docker pull ${DOCKER_HUB_USERNAME}/${DEV_IMAGE}:dev
                    docker tag ${DOCKER_HUB_USERNAME}/${DEV_IMAGE}:dev ${PROD_IMAGE}:prod
                    docker push ${DOCKER_HUB_USERNAME}/${PROD_IMAGE}:prod
                    docker rmi ${DOCKER_HUB_USERNAME}/${PROD_IMAGE}:prod
>>>>>>> a7da306060a6f50a01b961c76a427a287b39a645
                """
            }
        }
    }
}
}
