pipeline {
    agent any

    // Parameters are back, with your new IPs as the default
    parameters {
        string(
            name: 'ANSIBLE_PRIVATE_IP',
            defaultValue: '172.31.23.213', 
            description: 'Private IP of the Ansible Server'
        )
        string(
            name: 'WEB_SERVER_PUBLIC_IP',
            defaultValue: '52.55.187.225', // This is your NEW web server IP
            description: 'Public IP of the Web Server (for Nagios)'
        )
    }

    stages {
        stage('1. Deploy Website via Ansible') {
            steps {
                sshagent(['admp.pem']) {
                    sh """
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
                    sh """
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