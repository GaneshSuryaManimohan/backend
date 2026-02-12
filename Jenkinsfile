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
         NEXUS_URL = 'nexus.surya-devops.site:8081'
    }
    stages {
        stage('read the version'){
            steps{
                script{
                    def packageJson = readJSON file : 'package.json'
                    APP_VERSION = packageJson.version
                    echo "application version: ${APP_VERSION}"
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                sh """
                 npm install
                 ls -lrth
                 echo "application version: ${APP_VERSION}"
                """
            }
        }
        stage('Build') {
            steps {
                sh """
                 zip -q -r backend-${APP_VERSION}.zip * -x Jenkinsfile -x backend-${APP_VERSION}.zip
                 ls -ltr
                """
            }
        }

        stage('Nexus Artifact Upload') {
            steps {
                script{
                    nexusArtifactUploader(
                        nexusVersion: 'nexus3',
                        protocol: 'http',
                        nexusUrl: "${NEXUS_URL}",
                        groupId: 'com.expense',
                        version: "${APP_Version}",
                        repository: "backend",
                        credentialsId: 'nexus_auth',
                        artifacts: [
                            [artifactId: "backend",
                            classifier: '',
                            file: "backend-" + "${APP_VERSION}" + ".zip",
                            type: 'zip']
                        ]
                    )
                }
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