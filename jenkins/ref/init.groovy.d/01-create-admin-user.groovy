#!groovy

import jenkins.model.Jenkins
import hudson.security.*

def instance = Jenkins.getInstance()

if(!instance.isQuietingDown()) {
    def env = System.getenv()
    def hudsonRealm = new HudsonPrivateSecurityRealm(false)

    hudsonRealm.createAccount(env.JENKINS_USER, env.JENKINS_PASSWORD)
    instance.setSecurityRealm(hudsonRealm)
    instance.save()

    println 'User "' + env.JENKINS_USER + '" created.'
}
else {
    println "Shutdown mode enabled.  Create admin user SKIPPED."
}

