# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# My configuration
export LANG=en_US.UTF-8
export EDITOR='nvim'

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

### --- ZINIT ---
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

# --- PACKAGES ---
zinit ice depth"1"
zinit light romkatv/powerlevel10k
zinit light redxtech/zsh-asdf-direnv
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zdharma-continuum/history-search-multi-word

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
