pipeline {
    agent any

    stages {
        stage('Verified domain') {
            steps {
                sh "nslookup ${params.domain}.processmaker.net | grep '181.188.180.228'"
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