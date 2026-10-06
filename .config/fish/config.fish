if status is-interactive
    set -g fish_greeting ""
    alias g='git'
    alias ga='git add'
    alias gc='git commit -m'
    alias gp='git push'
    alias gst='git status'

    alias n='nvim'
    alias sn='sudo -E nvim'
    alias nf='n $(fzf)'

    alias pms='sudo pacman -S'
    alias pmsyu='sudo pacman -Syu'
    alias pmrns='sudo pacman -Rns'
    alias yas='yay -S'
    alias yarns='yay -Rns'

    if type -q lsd
        alias ls='lsd'
        alias l='ls -l'
        alias la='ls -a'
        alias lla='ls -la'
        alias lt='ls --tree'
    end
    
    if type -q zoxide
        alias cd='z'
    end

    if type -q opencode
        alias oc='opencode'
    end

    if type -q fastfetch
        alias ff='fastfetch'
    end
    alias cls='clear'

    zoxide init fish | source
    eval (ssh-agent -c) > /dev/null
    ssh-add ~/.ssh/nsugit > /dev/null
    clear
end

set -gx EDITOR nvim
set -gx PATH $HOME/.local/bin $PATH
# Бинари, установленные Mason'ом (postgres-language-server, pg_format и т.д.)
# Добавляем в конец, чтобы не перекрывать системные clang-format и т.п.
fish_add_path --append $HOME/.local/share/nvim/mason/bin

for file in ~/.config/fish/conf.d/*.fish
    source $file
end
