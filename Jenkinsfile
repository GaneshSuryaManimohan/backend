pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }

    environment{
        def appVersion = '' // Variable Declaration
    }
    stages {
        stage('read the version'){
            steps{
                script{
                    def packageJson = readJSON file : 'package.json'
                    appVersion = packageJson.version
                    echo "application version: $appVersion"
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                sh """
                 npm install
                 ls -lrth
                 echo "application version: $appVersion"
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
        }
        failure {
            echo 'shows upon failure'
        }
    }
}