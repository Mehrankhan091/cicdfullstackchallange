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
            // Testing PR
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

    }
}
