# OS specific configuration
system_type=$(uname -s)
echo $system_type

if [ "$system_type" = "Darwin" ]; then
  # Mac OS
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  # Linux
fi


# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
