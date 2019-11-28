pipeline {
    agent any

    stages {
        stage('Verified domain') {
            steps {
                sh 'nslookup ${params.domain}.processmaker.net | grep "Address:" | grep -Eo '(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$''
            }
        }
        stage('Create domain') {
            steps {
                echo 'Testing..'
            }
        }
        stage('CertBot SSL') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}