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
                try { 
                    sh "docker run -d -p 80:80 nginx/custom:latest"
                } catch (err) {
                    echo "Could not run a container. Trying to remove existing one and rerun"
                    currentBuild.result = 'UNSTABLE'
                    sh "docker rm -f $(docker ps -aq)"
                    sh "docker run -d -p 80:80 nginx/custom:latest"
                }
            }
        }
    }
}