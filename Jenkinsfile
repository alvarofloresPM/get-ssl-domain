pipeline {
    agent any

    stages {
        stage('Verifi domain') {
            steps {
                if (! nslookup ${params.domain}.processmaker.net | grep -o '181.188.180.228') {
                    autoCancelled = true
                    error('Aborting the build.')
                }
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