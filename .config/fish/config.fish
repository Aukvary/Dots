if status is-interactive
    set -g fish_greeting ""
    alias g='git'
    alias ga='git add'
    alias gc='git commit -m'
    alias gp='git push'
    alias gst 'git status'

    alias n='nvim'
    alias sn='sudo -E nvim'

    alias pms='sudo pacman -S'
    alias pmrns='sudo pacman -Rns'

    alias ls='lsd'
    alias l='ls -l'
    alias la='ls -a'
    alias lla='ls -la'
    alias lt='ls --tree'
    alias cat='bat'
    
    zoxide init fish | source
end

set -gx EDITOR nvim
set -gx PATH $HOME/.local/bin $PATH

for file in ~/.config/fish/conf.d/*.fish
    source $file
end
