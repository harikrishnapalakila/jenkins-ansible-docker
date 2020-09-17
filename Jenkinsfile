pipeline{
    agent any
    tools {
      maven 'maven3'
    }
    environment {
      DOCKER_TAG = getVersion()
    }
    options {
    buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '10', numToKeepStr: '10'))
    timestamps()
    retry(3)
    timeout time:10, unit:'MINUTES'
    }
    parameters {
    string      (defaultValue: "master", description: 'Branch Specifier', name: 'SPECIFIER')
    booleanParam(defaultValue: false, description: 'Deploy to QA Environment ?', name: 'DEPLOY_QA')
    booleanParam(defaultValue: false, description: 'Deploy to UAT Environment ?', name: 'DEPLOY_UAT')
    booleanParam(defaultValue: false, description: 'Deploy to PROD Environment ?', name: 'DEPLOY_PROD')
    }
    stages{
        stage("Initialize") {
             steps{
                sh "echo build has started....!!"
              }
        }
        stage('SCM'){
            steps{
                git credentialsId: 'github', 
                    url: 'https://github.com/javahometech/dockeransiblejenkins'
            }
        }
        
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        
        stage('Docker Build'){
            steps{
                sh "docker build . -t kammana/hariapp:${DOCKER_TAG} "
            }
        }
        
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u kammana -p ${dockerHubPwd}"
                }
                
                sh "docker push kammana/hariapp:${DOCKER_TAG} "
            }
        }
        
        stage('Docker Deploy'){
            steps{
              ansiblePlaybook credentialsId: 'dev-server', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
