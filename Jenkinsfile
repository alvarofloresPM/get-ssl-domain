pipeline {
    agent any
    
    stages {
        stage('Verify domain') {
            steps {
                sh "if ! nslookup ${params.domain}.processmaker.net | grep -o '181.188.180.228' ; then echo 'FAILURE - the domain do not exist or the ip public is incorrect'  ; exit 1 ; fi"
            }
        }
        stage('Create domain and SSL CertBot') {
            steps {
                sshagent (credentials: ['4326e3ee-90e1-4e8f-ad31-084a0cbec30d']) {
                    sh "if ! ssh -o StrictHostKeyChecking=no -l root 10.100.8.118 /opt/sslcert/SslScript.sh ${params.IPserver} ${params.domain} ${params.port} ${params.protocol}; then echo 'FAILURE - the server is down or do not exist' ; exit 1 ; fi "
                }
            }     
        }
        stage('Verify SSL domain') {
            steps {
                sshagent (credentials: ['4326e3ee-90e1-4e8f-ad31-084a0cbec30d']) {
                    sh "if ! ssh -o StrictHostKeyChecking=no -l root 10.100.8.118 nginx -t ; then echo 'FAILURE - review .conf file' ; exit 1 ; fi "
                }
            }     
        }
    }
    post {
        always {
            slackNotifier(currentBuild.currentResult)
            cleanWs()
        }
        success {  
            slackNotifier("Successfull")
            cleanWs()  
         }  
         failure {  
            slackNotifier("Failure")
            cleanWs();  
         }  
         unstable {  
            slackNotifier("Unstable")
            cleanWs()  
         }  
         changed {  
            slackNotifier("Status changed")
            cleanWs()
         }
    }
}