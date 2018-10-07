#!groovy

import jenkins.model.Jenkins

def instance = Jenkins.getInstance()

if(!instance.isQuietingDown()) {
    def jenkinsCli = instance.getDescriptor("jenkins.CLI").get()

    jenkinsCli.setEnabled(false)
    instance.save()

    println 'Disable CLI over Remoting'
}
else {
    println "Shutdown mode enabled.  Configure CLI remoting SKIPPED."
}

