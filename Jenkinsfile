pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    stages {
        stage('Install Dependencies') {
            steps {
                sh """
                 npm install
                 ls -lrth
                """
            }
        }
    }
    post {
        always {
            echo 'I will always say hello'
        }
        success {
            echo 'Shows Only upon success'
            cleanWs() // this ensure to delete the workspace after build is success
        }
        failure {
            echo 'shows upon failure'
        }
    }
}