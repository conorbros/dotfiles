if status is-interactive
    # Commands to run in interactive sessions can go here
end


alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gits='git status'
alias pacman='sudo pacman'
alias doom='$HOME/.emacs.d/bin/doom'
export PATH="$HOME/.cargo/bin:$PATH"
alias clippy-dirty="$HOME/scripts/clippy-dirty"

# unix tools
alias ls='lsd'
alias cat='bat'

# tools helpers
alias cargo-all-checks='cargo clippy --all-targets --locked --no-default-features -- -D warnings && cargo build --all-targets && cargo test && cargo fmt --all' 
alias cargo-clippy-fmt='cargo clippy --all-targets --locked --no-default-features -- -D warnings && cargo build --all-targets && cargo fmt --all' 
alias docker-rmi-untagged='docker rmi (docker images -a|grep "<none>"|awk \'$1=="<none>" {print $3}\') -f'
alias cargo-update-bins='cargo install (cargo install --list | egrep \'^[a-z0-9_-]+ v[0-9.]+:$\' | cut -f1 -d\' \')'
