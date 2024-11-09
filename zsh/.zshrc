if [ -z "$WAYLAND_DISPLAY" ] && \
	[ -n "$XDG_VTNR" ] && \
	[ "$XDG_VTNR" -eq 1 ] ; then
    exec dbus-run-session Hyprland
fi


# alias
alias rm='rm -i'
alias ls='ls --color=auto'

# Keybindigns
bindkey -v
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '\e[1;5D' backward-word # Ctrl+left
bindkey '\e[1;5C' forward-word # Ctrl+right
bindkey '\e[1;5A' beginning-of-line # Ctrl+up
bindkey '\e[1;5B' end-of-line # Ctrl+down

export WORDCHARS="${WORDCHARS//-/.}"

# oh-my-posh
if [ "$TERM" != "linux" ]; then
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

# WARNING: Having performance issues with this plugin
# zsh-completions
# zinit light zsh-users/zsh-completions
# load completions
# autoload -U compinit && compinit

# zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions

# fzf-tab
zinit light Aloxaf/fzf-tab

# zoxide
eval "$(zoxide init zsh)"



HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' # Case-insensitive tab completion
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}' # Color code completion menu
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
