pipeline {
    agent any

    options {
        office365ConnectorWebhooks {
            webhooks {
                webhook {
                    name('Slack-O365')
                    url('https://hooks.slack.com/services/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')
                    startNotification(false)
                    notifySuccess(true)
                    notifyAborted(false)
                    notifyNotBuilt(false)
                    notifyUnstable(true)
                    notifyFailure(true)
                    notifyBackToNormal(true)
                    notifyRepeatedFailure(false)
                    timeout(30000)
                }
            }
        }
    }

    stages {
        stage('Start') {
            steps {
                echo 'Lab_2: started by GitHub'
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'Lab_2', url: 'https://github.com/VladGrz/DDICN_Labs.git'
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

        stage('Test nginx/custom') {
            steps {
                sh 'docker run -v $WORKSPACE:/app vladgrz/ddicn sh -c "cat /app/index.html"'
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
                        sh "docker run -d -p 80:80 vladgrz/ddicn"
                    }
                }
            }
        }
    }
}