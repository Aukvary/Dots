if status is-interactive
    set -g fish_greeting ""
    alias g='git'
    alias ga='git add'
    alias gc='git commit -m'
    alias gp='git push'
    alias gst='git status'

    alias n='nvim'
    alias sn='sudo -E nvim'

    alias pms='sudo pacman -S'
    alias pmsyu='sudo pacman -Syu'
    alias pmrns='sudo pacman -Rns'
    alias yas='yay -S'
    alias yarns='yay -Rns'

    alias ls='lsd'
    alias l='ls -l'
    alias la='ls -a'
    alias lla='ls -la'
    alias lt='ls --tree'
    alias cls='clear'
    alias cd='z'
    
    zoxide init fish | source
    eval (ssh-agent -c) > /dev/null
    ssh-add ~/.ssh/nsugit > /dev/null
    clear
end

set -gx EDITOR nvim
set -gx PATH $HOME/.local/bin $PATH

for file in ~/.config/fish/conf.d/*.fish
    source $file
end
