#!groovy

import jenkins.model.Jenkins
import hudson.security.csrf.DefaultCrumbIssuer

def instance = Jenkins.getInstance()

if(!instance.isQuietingDown()) {
    if(instance.getCrumbIssuer() == null) {
        instance.setCrumbIssuer(new DefaultCrumbIssuer(true))
        instance.save()

        println 'CSRF Protection configuration has changed. Enabled CSRF Protection.'
    }
    else {
        println 'CSRF Protection already configured.'
    }
}
else {
    println "Shutdown mode enabled. Configure CSRF Protection SKIPPED."
}

