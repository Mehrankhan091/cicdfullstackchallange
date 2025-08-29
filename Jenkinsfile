pipeline {
    agent any
    tools{
        nodejs "nodejs"
    }

    stages {
        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
            post{
                success{
                    echo "====++++Install dependencies successful++++===="
                }
                failure{
                    echo "====++++Install dependencies failed++++===="
                }
            }
        }
        stage('Linter ') {
            steps {
                sh 'npm run lint'
            }
            post{
                success{
                    echo "====++++Linter  successful++++===="
                }
                failure{
                    echo "====++++Linter  failed++++===="
                }
            }
        }
        stage('Formatter') {
            steps {
                sh 'npm run prettier -- --write'
            }
            post{
                success{
                    echo "====++++ Formatter successful++++===="
                }
                failure{
                    echo "====++++Formatter  failed++++===="
                }
            }
        }
        stage('Test') {
            steps {
                sh 'CI=true npm run test'
            }
            post{
                success{
                    echo "====++++ Test successful++++===="
                }
                failure{
                    echo "====++++Test  failed++++===="
                }
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build'
            }
            post{
                success{
                    echo "====++++ Build successful++++===="
                }
                failure{
                    echo "====++++Build  failed++++===="
                }
            }
        }

        stage('Terraform Infra ') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_CRED', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    dir('terraform'){
                        script{
                            sh 'terraform init -input=false'

                            sh "terraform workspace new ${env.CHANGE_BRANCH} || terraform workspace select ${env.CHANGE_BRANCH} "

                            sh 'terraform plan -input=false'

                            sh 'terraform apply -input=false -auto-approve'
                        }
                    }
                }
            }
            post{
                success{
                    echo "====++++ Terraform infra success successful++++===="
                }
                failure{
                    echo "====++++Terraform infra success  failed++++===="
                }
            }
        }

        stage('Copy to s3') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_CRED', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh "aws s3 cp ./build/ s3://${env.CHANGE_BRANCH}-fullstack-web-challange-082925/"
            }
            }
            post{
                success{
                    echo "====++++ copy successful++++===="
                }
                failure{
                    echo "====++++copy failed++++===="
                }
            }
        }

    }
}
