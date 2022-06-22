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

# General aliases
alias zshc="nvim ~/.zshrc"
alias zshr="source ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimc="cd ~/.config/nvim && nvim"
alias lg="lazygit"
alias g="git"
alias gco="git checkout"
alias gac="git commit -am"
alias gpm="git checkout main && git pull"
alias gmm="git merge main"
alias la="exa -F -l -a -h --git"
alias ll="exa -F -l --git"
alias ls="exa -F --git"
alias copyc="xclip -sel c <"

# Work aliases
alias npd="npm run dev"
alias cdr="cd ~/Projects/ride"
alias cdrl="cd ~/Projects/ride/apps/lib"
alias cdrlb="cd ~/Projects/ride/apps/lib && npm run build"
alias cdrf="cd ~/Projects/ride/apps/frontend"
alias cdrq="cd ~/Projects/ride/apps/native/qickets"
alias cdrqs="cd ~/Projects/ride/apps/backend/edge-services/qickets-service"
alias cdrms="cd ~/Projects/ride/apps/backend/backend-services/media-service"
alias cdras="cd ~/Projects/ride/apps/backend/edge-services/abo-service"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# OS specific configuration
system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
  # Mac OS
else
  # Linux
fi

# Set up starship prompt
eval "$(starship init zsh)"

# Enable vi mode
bindkey -v
