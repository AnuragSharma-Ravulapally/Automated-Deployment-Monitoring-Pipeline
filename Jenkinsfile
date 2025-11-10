/**
 * This is your new, simplified Jenkinsfile.
 * It's updated based on your screenshots and IPs.
 * It removes the 'Copy' stage because your Ansible playbook
 * already clones the repo. This is much cleaner.
 */
pipeline {
    agent any

    // These parameters will be used in the pipeline.
    environment {
        ANSIBLE_PRIVATE_IP   = '172.31.23.213'
        WEB_SERVER_PUBLIC_IP = '98.93.250.181'
    }

    stages {
        // We don't need a 'Checkout' stage here,
        // because your Ansible playbook does the checkout.
        // Jenkins is just the "trigger".

        stage('1. Deploy Website via Ansible') {
            steps {
                // Use the 'admp.pem' credential you created in Jenkins
                sshagent(['admp.pem']) {
                    // 
                    // <<< FIX: Changed from ''' to """
                    // This allows Groovy to interpolate the ${params.ANSIBLE_PRIVATE_IP} variable
                    //
                    sh """
                    # SSH to Ansible server and run your deployment playbook
                    # Note: I am using your directory path '~/admp-ansible'
                    ssh -o StrictHostKeyChecking=no ubuntu@${params.ANSIBLE_PRIVATE_IP} '
                        cd ~/admp-ansible &&
                        ansible-playbook -i inventory.ini deploy_website.yml
                    '
                    """
                }
            }
        }

        stage('2. Configure Nagios Monitoring via Ansible') {
            steps {
                sshagent(['admp.pem']) {
                    //
                    // <<< FIX: Changed from ''' to """
                    // This allows Groovy to interpolate the ${params.ANSIBLE_PRIVATE_IP}
                    // and ${params.WEB_SERVER_PUBLIC_IP} variables
                    //
                    sh """
                    # SSH to Ansible server and run the monitoring playbook
                    # We pass the web server's public IP as an "extra var"
                    ssh -o StrictHostKeyChecking=no ubuntu@${params.ANSIBLE_PRIVATE_IP} '
                        cd ~/admp-ansible &&
                        ansible-playbook -i inventory.ini configure_monitoring.yml -e "web_server_public_ip=${params.WEB_SERVER_PUBLIC_IP}"
                    '
                    """
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