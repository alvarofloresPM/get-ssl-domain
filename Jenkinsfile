pipeline {
    agent any

    stages {
        stage('Verifi domain') {
            steps {
                sh "if ! nslookup ${params.domain}.processmaker.net | grep -o '181.188.180.228' ; then echo '[FAILURE] Failed to build' ; currentBuild.result = 'FAILURE' ; return ; fi"
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