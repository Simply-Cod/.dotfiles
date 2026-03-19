# Initialize the completion system
autoload -Uz compinit && compinit

# Case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{A-Z}={a-z}'


export EDITOR="nvim"
export SUDO_EDITOR="nvim"

# --- eza (better ls) ---
alias ls='eza -l --no-user --no-time --icons'
alias la='eza -l --no-user --no-time --icons -a'
alias list="eza -T -L 2"

source /usr/share/fzf/shell/key-bindings.zsh

# --- zoxide (cd) ---
eval "$(zoxide init bash)"

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


eval "$(starship init zsh)"

alias q="exit"
alias mux="$HOME/.build/mux.sh"
alias lg="lazygit"
