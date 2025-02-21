# Set the GPG_TTY to be the same as the TTY, either via the env var
# or via the tty command.
if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

# Autostart
## zodoxide
eval "$(zoxide init zsh)"
#eval "$(zoxide init --cmd cd zsh)"
#eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#source <(fzf --zsh)

## SSH
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## env
export PATH="/usr/local/bin:/usr/bin:$PATH"
export EDITOR=/usr/bin/nvim
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>:'
export CARGO_BUILD_JOBS=1
export RUST_MIN_STACK=16777216

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

#setopt autocd
##To change directory without cd. Example Documents is like cd Documents

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
export KEYTIMEOUT=1
#bindkey -v
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

## ctrl+<- | ctrl+->
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

## Delete
bindkey "^H"    backward-kill-word
bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word

## Home
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='eza --icons=always'
#alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias cd='z'
alias ..='cd ..'
alias ll='ls -lha --color=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias rm="trash"
alias kssh='kitty +kitten ssh'
#alias code="code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto"
alias wiki="wikiman"
alias fzf='fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"'

# Created by `pipx` on 2024-11-22 04:18:25
export PATH="$PATH:/home/brockar/.local/bin"
. "$HOME/.cargo/env"
