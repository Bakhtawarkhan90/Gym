pipeline {
    agent any 
    environment {
        SONAR_HOME = tool "Sonar"
        GITHUB_TOKEN = credentials('GithubToken')  // Use a Jenkins credential for GitHub PAT
        GITHUB_USERNAME = 'Bakhtawarkhan90'   // Replace with your GitHub username
    }
    stages{
        stage("Workspace Clean-up"){
            steps{
                script{
                    cleanWs()
                }
            }
        }
        stage("Clonning Code"){
            steps{
            git url:"https://github.com/Bakhtawarkhan90/Gym.git" , branch : "main"
            }
        }
        stage("Sonarqube Code Analysis"){
            steps{
                withSonarQubeEnv("Sonar") {
                    sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=Gym -Dsonar.projectKey=Gym -X"
                }
            }
        }
        stage("Docker Image Building"){
            steps{
                sh "docker build . -t gym:latest"
            }
        }
        stage('Trivy Image Scanning') {
            steps {
                echo "Trivy Image Scanning"
                retry(3) {
                    sh 'trivy image gym:latest || sleep 60'
                }
            }
        }
        stage("Push Docker-Hub"){
            steps{
                withCredentials([usernamePassword(credentialsId: "dockerHub", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]) {
                    sh "echo \$dockerHubPass | docker login -u \$dockerHubUser --password-stdin"
                    sh "docker tag gym:latest ${env.dockerHubUser}/gym:latest"
                    sh "docker push ${env.dockerHubUser}/gym:latest"
                }
            }
        }
        stage('OWASP DC') {
            steps {
                  dependencyCheck additionalArguments: '--scan .', odcInstallation: 'OWASP'
                  dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage("Deploy On K8s"){
            steps{
                sh " docker compose down "
                sh "docker compose up --build -d"
            }
        }
    }
    post {
        success {
            mail to: 'royalbakhtawar@gmail.com',
                subject: "Pipeline Success: ${currentBuild.fullDisplayName}",
                body: "The Pipeline '${env.JOB_NAME}' has successfully completed.\n" +
                      "Check it here: ${env.BUILD_URL}"
        }
        failure {
            mail to: 'royalbakhtawar@gmail.com',
                subject: "Pipeline Failed: ${currentBuild.fullDisplayName}",
                body: "The Pipeline '${env.JOB_NAME}' has failed.\n" +
                      "Check it here: ${env.BUILD_URL}"
        }
    }
}    
