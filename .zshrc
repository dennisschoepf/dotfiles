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
export PATH=/opt/homebrew/bin:$PATH
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH=$PATH:/Users/dennis/.spicetify

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
alias lm="fx"
alias la="exa -F -l -a -h --git"
alias ll="exa -F -l --git"
alias ls="exa -F --git"
alias copyc="xclip -sel c <"
alias grml="git branch --merged | egrep -v \"(^\*|master|dev)\" | xargs git branch -d"
alias v="nvim"

# YADM aliases
alias ys="yadm status"
alias yc="yadm add -u && yadm commit -am"
alias yp="yadm push"
alias yf="yadm pull"

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
alias cdrds="cd ~/Projects/ride/apps/backend/edge-services/dticket-service"
alias cdrd="cd ~/Projects/ride/apps/native/dticket"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set up starship prompt
eval "$(starship init zsh)"

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
