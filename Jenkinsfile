pipeline {
  agent {
    docker {
      image 'buaase-docenv'
      args '-u root -v $HOME/.ssh:/root/.ssh'
    }
  }
  stages{
    stage('Build') {
      steps {
        sh 'cmake --version'
        sh 'git remote set-url origin https://baixusata:a1216573454@github.com/baixusata/shattuckite-doc.git'
        sh 'git branch --set-upstream-to=origin/master master'
        sh ''' 
        git pull --tags;
        umask 000;
        mkdir -p build;
        cd build;
        rm * -Rf;
        cmake ..;
        make;
        '''
      }
    }
    stage('DeployToGIT') {
      when{
        branch 'master'
      }
      steps{
        sh 'pwd'
        sh 'chmod a+x ./deployTools/deployToGIT.sh'
        sh './deployTools/deployToGIT.sh'
      }
    }

    stage('DeployToWebServer') {
      when{
        branch 'master'
      }
      steps{
        sh 'pwd'
        sh 'chmod a+x ./deployTools/deployToServer.sh'
        sh './deployTools/deployToServer.sh'
      }
    }
  }
  post {
    always {
        archiveArtifacts artifacts: 'build/shattuckite-v*.*.pdf', fingerprint: true
    }
  }
}
