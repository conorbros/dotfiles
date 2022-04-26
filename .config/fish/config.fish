if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim='nvim'
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
alias cargo-all-checks='cargo clippy --all-targets --locked --no-default-features -- -D warnings && cargo build --all-targets && cargo test --all-features && cargo fmt --all' 
alias cargo-clippy-fmt='cargo clippy --all-targets --locked --no-default-features -- -D warnings && cargo build --all-targets && cargo fmt --all' 
alias docker-rmi-untagged='docker rmi (docker images -a|grep "<none>"|awk \'$1=="<none>" {print $3}\') -f'
alias cargo-update-bins='cargo install (cargo install --list | egrep \'^[a-z0-9_-]+ v[0-9.]+:$\' | cut -f1 -d\' \')'
alias cargo-clean-all='find . -name Cargo.toml -type f -execdir cargo clean \;'

alias update-system='rustup update && pacman -Syyu && yay -Syyu && doom upgrade && cargo-update-bins'

# openssl build stuff
export OPENSSL_LIB_DIR="/usr/lib/openssl-1.0"
export OPENSSL_INCLUDE_DIR="/usr/include/openssl-1.0"
