#!groovy

import jenkins.model.Jenkins
import org.jenkinsci.plugins.simpletheme.CssUrlThemeElement

def instance = Jenkins.getInstance()

if(!instance.isQuietingDown()) {
    def simpletheme = instance.getDescriptor("org.codefirst.SimpleThemeDecorator")

    simpletheme.getElements().add(new CssUrlThemeElement("https://cdn.rawgit.com/afonsof/jenkins-material-theme/gh-pages/dist/material-teal.css"))
    simpletheme.save()

    println "Jenkins theme changed."
}
else {
    println "Shutdown mode enabled. Change Jenkins theme SKIPPED."
}
