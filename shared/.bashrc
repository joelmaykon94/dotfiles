# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
if [ -f "$HOME/.local/share/omarchy/default/bash/rc" ]; then
    source "$HOME/.local/share/omarchy/default/bash/rc"
fi

# PATH personalizado
export PATH="$HOME/.local/bin:$PATH"

# Aliases rápidos
alias dot='cd ~/Projects/dotfiles'
alias gs='git status'
alias gp='git push'

# Carregar segredos locais e configurações privadas (não versionadas)
if [ -f "$HOME/.bashrc.local" ]; then
    source "$HOME/.bashrc.local"
fi
