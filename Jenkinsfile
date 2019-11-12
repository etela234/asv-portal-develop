node { 
    stage 'Check Out Code Repository'
        checkout scm
    stage 'build prject'
        sh 'mvn clean package'
    stage 'run prject'
        sh 'java -cp target/asvportal.war'
    stage 'deploy app to node'
        ansiblePlaybook(credentialsId: 'private_main', inventory: 'roles/inventory.ini', playbook: 'roles/main.yml', disableHostKeyChecking: true)     
 }
