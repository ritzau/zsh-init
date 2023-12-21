SSH_AGENT_CFG="$HOME/.ssh/agent-cfg-$HOST.sh"

function start_ssh_agent() {
  ssh-agent | sed '/^echo/d' > "$SSH_AGENT_CFG"
  chmod 600 "$SSH_AGENT_CFG"
  . "$SSH_AGENT_CFG"
  ssh-add --apple-load-keychain
}

if [[ -f $SSH_AGENT_CFG ]]
then
  . "$SSH_AGENT_CFG"
  if ! ps x | grep ssh-agent | grep -q $SSH_AGENT_PID
  then
    start_ssh_agent
  fi
else
  start_ssh_agent
fi

unfunction start_ssh_agent
