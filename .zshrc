# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# My configuration
export LANG=en_US.UTF-8
export EDITOR='nvim'
export GOPATH=$HOME/go
export VOLTA_HOME=$HOME/volta

# PATH variables
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/usr/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$VOLTA_HOME/bin:$PATH

# General aliases
alias zshc="nvim ~/.zshrc"
alias zshr="source ~/.zshrc"
alias nvimc="cd ~/.config/nvim && nvim"
alias lg="lazygit"
alias lzd="lazydocker"
alias g="git"
alias gco="git checkout"
alias gac="git commit -am"
alias gpm="git checkout main && git pull"
alias gpc="git cherry-pick"
alias gmm="git merge main"
alias lm="fx"
alias la="eza -F -l -a -h --git"
alias ll="eza -F -l --git"
alias ls="eza -F --git"
alias copyc="xclip -sel c <"
alias grml="git branch --merged | egrep -v \"(^\*|master|dev)\" | xargs git branch -d"
alias v="nvim"
alias tmuxrefresh="stty sane; printf '\033k%s\033\\\033]2;%s\007' "`basename "$SHELL"`" "`uname -n`"; tput reset; tmux refresh"
alias stgui="ssh -L 9090:localhost:8384 dnsc"
alias cat="bat"
alias t="nvim ~/notes/todo.txt +$"
alias ts="tmux split-window -h \"nvim ~/notes/todo.txt +$\""

# YADM aliases
alias ys="yadm status"
alias yc="yadm add -u && yadm commit -am"
alias yp="yadm push"
alias yf="yadm pull"

# Work specific config
if [[ $(hostname) == "contraption.digital-h.de" ]]; then
  # Add homebrew to path
  export PATH=/opt/homebrew/bin:$PATH

  # Android Dev Setup
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/platform-tools

  # Work aliases
  alias npd="npm run dev"
  alias cdr="cd ~/Projects/ride"
  alias cdrl="cd ~/Projects/ride/apps/lib"
  alias cdrlb="cd ~/Projects/ride/apps/lib && npm run build"
  alias cdrf="cd ~/Projects/ride/apps/frontend"
  alias cdrq="cd ~/Projects/ride/apps/native/qickets"
  alias cdrqs="cd ~/Projects/ride/apps/backend/edge-services/qickets-service"
  alias cdrms="cd ~/Projects/ride/apps/backend/backend-services/main-service"
  alias cdrfs="cd ~/Projects/ride/apps/backend/backend-services/flex-subscription-service"
  alias cdrps="cd ~/Projects/ride/apps/backend/backend-services/pay-service"
  alias cdrts="cd ~/Projects/ride/apps/backend/backend-services/tariff-service"
  alias cdrmes="cd ~/Projects/ride/apps/backend/backend-services/media-service"
  alias cdras="cd ~/Projects/ride/apps/backend/edge-services/abo-service"

  ## NVM Setup
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

### --- ZINIT ---
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# --- PACKAGES ---
zinit ice depth"1"
zinit light romkatv/powerlevel10k
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
### End of Zinit's installer chunk

# Tmux Autostart
if [ -z "$TMUX" ]; then
  if [[ $(hostname) == "contraption.digital-h.de" ]]; then
    exec tmux new-session -A -s dev
  else
    exec tmux new-session -A -s main
  fi
fi


eval "$(atuin init zsh)"
