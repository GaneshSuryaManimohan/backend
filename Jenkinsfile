pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    // Initializing .tf
    stages {
        stage('Init') {
            steps {
                sh """
                 ls -larth
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