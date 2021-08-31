if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gits='git status'
alias pacman='sudo pacman'
alias doom='$HOME/.emacs.d/bin/doom'
export PATH="$HOME/.cargo/bin:$PATH"
alias clippy-dirty="$HOME/scripts/clippy-dirty"
alias ls='lsd'
alias cat='bat'
