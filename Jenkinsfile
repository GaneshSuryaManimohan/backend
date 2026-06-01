@Library('jenkins-shared-lib') _

// create a variable of map type and set values

def configMap = [
    type: "nodejsEKS",
    component: "backend",
    project: "expense"
]

if( ! env.BRANCH_NAME.equalsIgnoreCase('main')){
    pipelinedcsn.decidePipeline(configMap)
}
else{
    echo "Proceed with CR or NON-PROD pipeline"
}


