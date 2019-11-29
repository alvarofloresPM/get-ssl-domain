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
                ssh "ssh -q -o BatchMode=yes -o ConnectTimeout=10 ${params.IPserver} exit ; if [ $? -ne 0 ] ; then exit 1 ; echo 'FAILURE - the server is down or don not exist' ; fi"
                sshagent (credentials: ['4326e3ee-90e1-4e8f-ad31-084a0cbec30d']) {
                    sh "ssh -o StrictHostKeyChecking=no -l root 10.100.8.118 /opt/SslScript.sh ${params.IPserver}"
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