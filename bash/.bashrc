
export EDITOR="nvim"
export SUDO_EDITOR="nvim"

alias lg="lazygit"

# --- eza (better ls) ---
alias ls='eza -l --no-user --no-time --icons'
alias la='eza -l --no-user --no-time --icons -a'
alias list="eza -T -L 2"

source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

# --- Starship ---
eval "$(starship init bash)"

# --- zoxide (cd) ---
eval "$(zoxide init bash)"

# --- arch specific ---
alias pac-install="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pac-remove="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
