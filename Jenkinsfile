pipeline {
    agent any
    
    stages {
         stage('Slack Notification') {
             steps {
             slackSend color: '#009623', message: "STARTED: ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
             }
         }
        stage('Verify domain') {
            steps {
                sh "if ! nslookup ${params.SubDomain}.${params.domain} | grep -o '181.188.180.228' ; then echo 'FAILURE - the domain do not exist or the ip public is incorrect'  ; exit 1 ; fi"
            }
        }
        stage('Create domain and SSL CertBot') {
            steps {
                sshagent (credentials: ['4326e3ee-90e1-4e8f-ad31-084a0cbec30d']) {
                    sh "if ! ssh -o StrictHostKeyChecking=no -l root 10.100.8.118 /opt/sslcert/SslScript.sh ${params.IPserver} ${params.SubDomain}.${params.domain} ${params.port} ${params.protocol} ${params.ProcessMaker4}; then echo 'FAILURE - the server is down or do not exist also the configuration already exist in the server' ; exit 1 ; fi "
                }
            }     
        }
        stage('Verify SSL domain') {
            steps {
                sshagent (credentials: ['4326e3ee-90e1-4e8f-ad31-084a0cbec30d']) {
                    sh "if ! ssh -o StrictHostKeyChecking=no -l root 10.100.8.118 nginx -t && nginx -s reload ; then echo 'FAILURE - review .conf file' ; exit 1 ; fi "
                }
            }     
        }
    }
    post {
         success {  
             slackSend color: '#00FF00', message: "SUCCESSFUL: Job, ${params.SubDomain}.${params.domain} domain was created" 
          }  
          failure {  
             slackSend color: '#FF0000', message: 'FAILED: Job, check logs for more details'; 
          }  
          unstable {  
             slackSend color: '#fff700', message: 'UNSTABLE: Job'
          }  
          changed {  
             slackSend color: '#000dff', message: 'STATUS CHANGED: Job'
          }
    }
}