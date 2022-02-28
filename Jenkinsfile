#!/usr/bin/env groovy

def APP_NAME = 'comp-engine-microservices'
def isDiployable =true
def isRelease =false
def isPredProd = true

// Define your secret project token here by shjio
//def project_token = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEF'

// Reference the GitLab connection name from your Jenkins Global configuration (https://JENKINS_URL/configure, GitLab section)
//properties([gitLabConnection('44534abe-a8b7-4020-827a-e7cb74cd864b')])//git api token 
//properties([gitLabConnection('645b5e8c-3c20-4e10-a18e-ef1148ced536')])//gitlab username



def runsecurity(appname, para2) {
  stage('policy') {
    echo "shjo This is a policy shjo ${appname} and ${para2}"
  }
}  

def deploytoenv(appname, para2) {
  stage('Deploy') {
    echo " shjo deployement being progressed [shjo ${appname} and ${para2}]"
  }
  stage("Waiting for end point") {
     echo "shjo rebooting/refreshing the env..."
  }

  //testing by shjo 4
  stage('analysis') {
    echo "shjo This is a run security function in jenkin shjo"
  }
}

node {
    try {      
        stage('clean') {
          echo "this is a clean"      
        }
        stage('checkout') {
          echo "this is checkout scm "
            checkout scm
        }
        stage('Run Py for QA Shakeout') {
          echo "this is checkout we can call the py file"      
        }
        
        stage('git tag'){
           // environment {
           //     gitlab_username = credentials('645b5e8c-3c20-4e10-a18e-ef1148ced536') shailend
              // gitlabApi_token = credentials('44534abe-a8b7-4020-827a-e7cb74cd864b')
            //}           
            withCredentials([usernamePassword(credentialsId: '645b5e8c-3c20-4e10-a18e-ef1148ced536', 
                          passwordVariable: 'gitlab_password', usernameVariable: 'gitlab_username')]) {
                    //gitlab_username_USR
                    //gitlab_username_PSW
                  //withCredentials([usernamePassword(credentialsId: '645b5e8c-3c20-4e10-a18e-ef1148ced536',
                    //     passwordVariable: gitlab_username_PSW,usernameVariable: gitlab_username_USR)]){                
                      //sh 'git tag DEV-TAG-10'
                      //sh 'git push origin DEV-TAG-10'hhgfh
                      GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
                      sh('git tag DEV-TAG-16 ${GIT_COMMIT_HASH}')                      
                      sh "echo 'commit hash is ${GIT_COMMIT_HASH}'"
                      sh('git push origin https://${gitlab_username}:${gitlab_password}@git:80/root/comp-engine-microservices.git DEV-TAG-16')                      //sh 'echo '+"pushed a tig tag"                
                      //sh "echo 'my password is $gitlab_username_PSW'"
                      //sh "echo 'my gitlab username credential is $gitlab_username'"
                      //sh "echo 'my gitlab token is $gitlabApi_token'"
                             // }        
             }
          }                     
    }           
    catch (e) {
        echo "BUild is failed"
        throw(e)
    }     
}
 
try {
  if (isDiployable) {
    if (isRelease) {
      node {
        runsecurity('SHJO APPNAME','PARA2 SHJO')
        echo "Deploy to Stg"
      }

      stage("Proceed to prod") {
        timeout(time: 48, unit: "HOURS") {
          input(message: 'Push to Prod')
        }
      }

      node {
        echo "Deployed to prod"
      }
    } else if (isPredProd) {
      node {
        echo "deploy to Pre Prod"
      }
    } else {
      node {
        echo "Deploye to Dev"
      }
      stage("proceed to QA") {
        timeout(time: 48, unit: 'HOURS') {
          input "Proceed/Abort deployment to QA"
        }
      }
      node {
        echo "Deploye to QA"
      }
    }
  } 
}catch(e){
      echo "build has been failed"
      throw(e)
}