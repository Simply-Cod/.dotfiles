#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo "Please provide a session name"
    exit 1
fi
name="$1"

tmux has-session -t $name 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $name -n "Neovim"
    tmux send-keys -t $name:"Neovim" 'nvim' C-m

    tmux new-window -t $name -n "Terminal"

    tmux select-window -t $name:"Neovim"
fi

tmux attach-session -t $name
