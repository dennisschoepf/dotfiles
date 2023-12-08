# My configuration
export LANG=en_US.UTF-8
export EDITOR='nvim'
# export ZSH_TMUX_AUTOSTART=true
bindkey -v
export KEYTIMEOUT=1

# PATH variables
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/usr/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=/usr/local/bin:$PATH

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

# YADM aliases
alias ys="yadm status"
alias yc="yadm add -u && yadm commit -am"
alias yp="yadm push"
alias yf="yadm pull"

