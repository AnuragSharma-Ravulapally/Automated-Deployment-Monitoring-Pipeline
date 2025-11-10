pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-pat-global', // Replace with your Jenkins credential ID for PAT
                    url: 'https://github.com/AnuragSharma-Ravulapally/Automated-Deployment-Monitoring-Pipeline'
            }
        }

        stage('Deploy using Ansible') {
            steps {
                sshagent(['ansible-key']) { // Replace with your Jenkins SSH key ID used for Ansible server
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@<ANSIBLE_PRIVATE_IP> '
                        cd ~/admp-ansible &&
                        ansible-playbook -i inventory.ini deploy_website.yml
                    '
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment Successful!"
        }
        failure {
            echo "❌ Deployment Failed! Check the console logs."
        }
    }
}
