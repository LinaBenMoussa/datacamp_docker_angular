pipeline {
    agent any
    tools {
        jdk 'JDK17'
    }
    environment {
        DOCKER_TAG = getVersion()
    }
    stages {
        stage('Clone Stage') {
            steps {
                git "https://github.com/LinaBenMoussa/datacamp_docker_angular.git"
            }
        }
        stage('Docker Build') {
            steps {
                sh "docker build -t linabenmoussa150/angulardockerproject:${DOCKER_TAG} ."
            }
        }
        stage('DockerHub Push') {
            steps {
                withCredentials([string(credentialsId: '317e9fff-659e-4895-bc13-81651f33b049', variable: 'DockerHubPassword')]) {
                    sh "docker login -u linabenmoussa150 -p ${DockerHubPassword}"
                }
                sh "docker push linabenmoussa150/angulardockerproject:${DOCKER_TAG}"
            }
        }
        stage('Deploy') {
            steps {
                sshagent(credentials: ['vagrant_ssh']) {
                    sh "ssh vagrant@192.168.250.227 'sudo docker run linabenmoussa150/angulardockerproject:${DOCKER_TAG}'"
                }
            }
        }
    }
}

def getVersion() {
    def version = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
    return version
}
