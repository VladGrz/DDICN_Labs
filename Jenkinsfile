pipeline {
    agent any

    stages {
        stage('Start') {
            steps {
                echo 'Lab_1: nginx/custom'
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'Lab_1', url: 'https://github.com/VladGrz/DDICN_Labs.git'
            }
        }

        stage('Build nginx/custom') {
            steps {
                sh 'docker build -t nginx/custom:latest .'
            }
        }

        stage('Test nginx/custom') {
            steps {
                sh 'docker run -v $WORKSPACE:/app nginx/custom:latest sh -c "cat /app/index.html"'
            }
        }

        stage('Deploy nginx/custom'){
            steps{
                catchError(buildResult: true, stageResult: true) { 
                    sh "docker run -d -p 80:80 nginx/custom:latest"
                }
                finally {
                    if (currentBuild.result == 'FAILURE') {
                        sh "docker rm -f $(docker ps -aq)"
                        sh "docker run -d -p 80:80 nginx/custom:latest"
                    }
                }
            }
        }
    }
}