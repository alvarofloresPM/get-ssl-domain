pipeline {
    agent any
    
    stages {
        stage('Verifi domain') {
            steps {
                sh "if ! nslookup ${params.domain}.processmaker.net | grep -o '181.188.180.228' ; then echo 'FAILURE - the domain do not exist or the ip public is incorrect'  ; exit 1 ; fi"
            }
        }
        stage('Create domain') {
            steps {
                sshagent (credentials: ['4326e3ee-90e1-4e8f-ad31-084a0cbec30d']) {
                    sh "ssh -o StrictHostKeyChecking=no -l root ${params.IPserver} /opt/SslScript.sh ${params.IPserver}"
                }
                try {
                   error 'fail on purpose...'
                } catch (e) {
                    echo "Caught exception: ${e}"
                }
            }
        }
        stage('CertBot SSL') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}