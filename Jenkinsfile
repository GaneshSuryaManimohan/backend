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
         APP_VERSION = '' // Variable Declaration
    }
    stages {
        stage('read the version'){
            steps{
                script{
                    dir('backend') {
                    def packageJson = readJSON file : 'package.json'
                    env.APP_VERSION = packageJson.version
                    echo "application version: ${env.APP_VERSION}"
                    }
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                sh """
                 npm install
                 ls -lrth
                 echo "application version: ${env.APP_VERSION}"
                """
            }
        }
        stage('Build') {
            steps {
                sh """
                 zip -q -r backend-${env.APP_VERSION}.zip * -x Jenkinsfile -x backend-${env.APP_VERSION}.zip
                 ls -ltr
                """
            }
        }
    }
    post {
        always {
            echo 'I will always say hello'
            deleteDir()
        }
        success {
            echo 'Shows Only upon success'
        }
        failure {
            echo 'shows upon failure'
        }
    }
}