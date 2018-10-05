#!groovy

import jenkins.model.Jenkins
import hudson.security.*

def instance = Jenkins.getInstance()

if(!instance.isQuietingDown()) {
    def env = System.getenv()
    def strategy = new GlobalMatrixAuthorizationStrategy()

    strategy.add(Jenkins.ADMINISTER, env.JENKINS_USER)
    instance.setAuthorizationStrategy(strategy)
    instance.save()

    println 'Add role "' + Jenkins.ADMINISTER + '" to "' + env.JENKINS_USER + '" user.'
}
else {
    println "Shutdown mode enabled.  Create admin user SKIPPED."
}

