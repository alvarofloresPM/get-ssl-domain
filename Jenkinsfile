pipeline {
    agent any
    
    stages {
        // stage('Slack Notification') {
        //     steps {
        //     slackSend color: '#009623', message: "STARTED: ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
        //     }
        // }
        stage('Verify Params') {
            steps {
                sh "if ! ${params.IPserver} =~ ^[0-9]+/.[0-9]+/.[0-9]+/.[0-9]+$ ; then  echo 'FAILURE - IP address' ; exit 1; fi"
                sh "if ! ${params.port} =~ ^[0-9]+$ ; then  echo 'FAILURE - port' ; exit 1; fi"
                sh "if ! ${params.protocol} =~ ^http|https$ ; then  echo 'FAILURE - protocol' ; exit 1; fi"
                sh "if ! ${params.domain} =~ ^[a-z]+$ ; then  echo 'FAILURE - IP domain' ; exit 1; fi"
            }
        }
        // stage('Verify domain') {
        //     steps {
        //         sh "if ! nslookup ${params.domain}.processmaker.net | grep -o '181.188.180.228' ; then echo 'FAILURE - the domain do not exist or the ip public is incorrect'  ; exit 1 ; fi"
        //     }
        // }
        // stage('Create domain and SSL CertBot') {
        //     steps {
        //         sshagent (credentials: ['4326e3ee-90e1-4e8f-ad31-084a0cbec30d']) {
        //             sh "if ! ssh -o StrictHostKeyChecking=no -l root 10.100.8.118 /opt/sslcert/SslScript.sh ${params.IPserver} ${params.domain} ${params.port} ${params.protocol}; then echo 'FAILURE - the server is down or do not exist' ; exit 1 ; fi "
        //         }
        //     }     
        // }
        // stage('Verify SSL domain') {
        //     steps {
        //         sshagent (credentials: ['4326e3ee-90e1-4e8f-ad31-084a0cbec30d']) {
        //             sh "if ! ssh -o StrictHostKeyChecking=no -l root 10.100.8.118 nginx -t ; then echo 'FAILURE - review .conf file' ; exit 1 ; fi "
        //         }
        //     }     
        // }
    }
    // post {
    //     success {  
    //         slackSend color: '#00FF00', message: 'SUCCESSFUL: Job'  
    //      }  
    //      failure {  
    //         slackSend color: '#FF0000', message: 'FAILED: Job';  
    //      }  
    //      unstable {  
    //         slackSend color: '#fff700', message: 'UNSTABLE: Job'
    //      }  
    //      changed {  
    //         slackSend color: '#000dff', message: 'STATUS CHANGED: Job'
    //      }
    // }
}