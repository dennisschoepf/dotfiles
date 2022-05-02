# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  git-auto-fetch
  jsontools
  rsync
  cp
  ubuntu
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# My configuration
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# Android Dev Setup
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# PATH variables
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/usr/bin"
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/bin:$PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Example aliases
alias zshconf="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias npd="npm run dev"
alias lg="lazygit"
alias g="git"
alias gco="git checkout"
alias gac="git commit -am"
alias gpm="git checkout main && git pull"
alias gmm="git merge main"
alias la="exa -F -l -a -h --git"
alias ll="exa -F -l --git"
alias ls="exa -F --git"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# OS specific configuration
system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
  # Mac OS
else
  # Linux
  alias kitty="kitty --config .config/kitty-linux/kitty.conf"
fi

# Set up starship prompt
eval "$(starship init zsh)"

# Enable vi mode
bindkey -v
