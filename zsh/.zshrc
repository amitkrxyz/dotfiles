if [ -z "$WAYLAND_DISPLAY" ] && \
	[ -n "$XDG_VTNR" ] && \
	[ "$XDG_VTNR" -eq 1 ] ; then
    exec dbus-run-session Hyprland
fi


# alias
alias rm='rm -i'

# eza
if command -v eza > /dev/null; then
	alias ls="eza --icons=auto --hyperlink"
else
	alias ls='ls --color=auto -F'
fi

alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'

# environment variables
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export EDITOR="nvim"

# Path
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/development/flutter:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Application/:$PATH"
export PATH="$HOME/.local/scripts:$PATH"
## Android
export ANDROID_HOME=$HOME/Android
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin/:$PATH
export PATH=$ANDROID_HOME/emulator/:$PATH
export PATH=$ANDROID_HOME/platform-tools/:$PATH
export PATH="$HOME/development/flutter/bin:$PATH"


# linuxbrew
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# Keybindigns
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^h' backward-kill-word # Ctrl+backspace
bindkey '\e[1;5D' backward-word # Ctrl+left
bindkey '\e[1;5C' forward-word # Ctrl+right
bindkey '\e[1;5A' beginning-of-line # Ctrl+up
bindkey '\e[1;5B' end-of-line # Ctrl+down

export WORDCHARS="${WORDCHARS//-/.}"

# Deafult prompt
PROMPT='%F{green}%~ %f$ '

# oh-my-posh
if [ "$TERM" != "linux" ] && command -v oh-my-posh > /dev/null; then
	eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/tokyonight_storm.json)"
fi

# zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && \
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# zsh-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting

# WARNING: May have performance issues with this plugin
# zsh-completions
zinit light zsh-users/zsh-completions
# load completions
autoload -U compinit && compinit

# zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions

# fzf-tab
zinit light Aloxaf/fzf-tab

# fzf
if command -v fzf > /dev/null; then
	source <(fzf --zsh)
fi

# zoxide
unalias zi
eval "$(zoxide init zsh)"

# atuin
eval "$(atuin init zsh --disable-up-arrow)"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

#Completion styling
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' # Case-insensitive tab completion
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}' # Color code completion menu
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
