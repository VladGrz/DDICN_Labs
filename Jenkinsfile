pipeline {
    agent any

    stages {
        stage('Start') {
            steps {
                echo 'Lab_5: started by Cron'
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'Lab_5', url: 'https://github.com/VladGrz/DDICN_Labs.git'
            }
        }

	

        stage('Test') {
            steps {
                sh 'echo "Doing something"'
            }
        }

        stage('Test notification'){
            steps {
                office365ConnectorSend webhookUrl: "${TEAMS_WEBHOOK_URL}", message: "Catched an error when deploying an image. Check ${env.BUILD_URL}"
            }
        }
    }
}
