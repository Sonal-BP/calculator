pipeline{
    agent any
    tools{
        maven"mymaven"
    }
    stages{
        stage("checkoutfromgit"){
            steps{
                git url:'https://github.com/Sonal-BP/calculator.git'
            }
        }
        stage("codecompile"){
            steps{
               bat "mvn compile"
            }
        }
        stage("build"){
            
            steps{
                bat "mvn clean package"
                echo "Build stage"
                stash 'source'
            }
        }
        
        stage("deploy")
        {
            agent{
                label 'test'
            }
            steps{
                unstash 'source'
                echo "deploy stage"
                
            }
        }
        
    }
}
