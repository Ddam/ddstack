#!/bin/sh

set -ex

write_key() {
  mkdir -p "${JENKINS_AGENT_HOME}/.ssh"
  echo "$1" > "${JENKINS_AGENT_HOME}/.ssh/authorized_keys"
  chown -Rf jenkins:jenkins "${JENKINS_AGENT_HOME}/.ssh"
  chmod 0700 -R "${JENKINS_AGENT_HOME}/.ssh"
}

if [[ $JENKINS_SLAVE_SSH_PUBKEY == ssh-* ]]; then
  write_key "${JENKINS_SLAVE_SSH_PUBKEY}"
fi
if [[ $# -gt 0 ]]; then
  if [[ $1 == ssh-* ]]; then
    write_key "$1"
    shift 1
  else
    ssh-keygen -A
    "$@" & #-E /var/log/sshd.log
  fi
fi

env | grep _ >> /etc/environment

ssh-keygen -A
set -- /usr/sbin/sshd -e -D "${@}"

"${@}" &

exec "$(which dind)" dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375
