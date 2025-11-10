/**
 * This is the updated Jenkinsfile with your new IPs and credential ID.
 * Commit this file to the root of your GitHub repository.
 */
pipeline {
    agent any

    // These parameters will be used in the pipeline.
    // I've updated the IPs with the ones you provided.
    parameters {
        string(name: 'ANSIBLE_PRIVATE_IP', defaultValue: '172.31.23.213', description: 'Private IP of the Ansible Server')
        string(name: 'WEB_SERVER_PUBLIC_IP', defaultValue: '98.93.250.181', description: 'Public IP of the Web Server (for Nagios)')
    }

    stages {
        stage('1. Checkout Code') {
            steps {
                git branch: 'main',
                    // This credential ID must exist in Jenkins
                    credentialsId: 'github-pat-global', 
                    url: 'https://github.com/AnuragSharma-Ravulapally/Automated-Deployment-Monitoring-Pipeline'
            }
        }

        stage('2. Copy Artifact to Ansible Server') {
            steps {
                // Use the 'admp.pem' SSH key credential
                // This ID must exist in Jenkins
                sshagent(['admp.pem']) {
                    sh '''
                    # Copy the index.html file from Jenkins workspace to your Ansible project directory
                    scp -o StrictHostKeyChecking=no index.html ubuntu@${params.ANSIBLE_PRIVATE_IP}:~/admp-ansible/index.html
                    '''
                }
            }
        }

        stage('3. Deploy Website via Ansible') {
            steps {
                sshagent(['admp.pem']) {
                    sh '''
                    # SSH to Ansible server and run the deployment playbook
                    ssh -o StrictHostKeyChecking=no ubuntu@${params.ANSIBLE_PRIVATE_IP} '
                        cd ~/admp-ansible &&
                        ansible-playbook -i inventory.ini deploy_website.yml
                    '
                    '''
                }
            }
        }

        stage('4. Configure Nagios Monitoring via Ansible') {
            steps {
                sshagent(['admp.pem']) {
                    sh '''
                    # SSH to Ansible server and run the monitoring playbook
                    # We pass the web server's public IP as an "extra var"
                    ssh -o StrictHostKeyChecking=no ubuntu@${params.ANSIBLE_PRIVATE_IP} '
                        cd ~/admp-ansible &&
                        ansible-playbook -i inventory.ini configure_monitoring.yml -e "web_server_public_ip=${params.WEB_SERVER_PUBLIC_IP}"
                    '
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ ADMP Pipeline Successful! Website deployed and monitoring is active."
            echo "Access your site at: http://${params.WEB_SERVER_PUBLIC_IP}"
        }
        failure {
            echo "❌ ADMP Pipeline Failed! Check the console logs."
        }
    }
}