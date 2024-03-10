pipeline {
    agent any

    stages {
        stage('Start') {
            steps {
                echo 'Lab_2: started by GitHub'
            }
        }

        stage('Image build') {
            steps {
                sh "docker build -t ddicn:latest ."
                sh "docker tag ddicn vladgrz/ddicn:latest"
                sh "docker tag ddicn vladgrz/ddicn:$BUILD_NUMBER"
            }
        }

        stage('Push to registry') {
            steps {
                withDockerRegistry([ credentialsId: "dockerhub_token", url: "" ]) {
                    sh "docker push vladgrz/ddicn:latest"
                    sh "docker push vladgrz/ddicn:$BUILD_NUMBER"
                }
            }
        }

        stage('Deploy image'){
            steps{
                script {
                    try { 
                        sh "docker run -d -p 80:80 vladgrz/ddicn"
                    } catch (err) {
                        echo "Could not run a container. Trying to remove existing one and rerun"
                        currentBuild.result = 'UNSTABLE'
                        sh 'docker rm -f $(docker ps -aq)'
                        sh "docker run -d -p 80:80 nginx/custom:latest"
                    }
                }
            }
        }
    }
}