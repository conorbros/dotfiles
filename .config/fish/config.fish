if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim='nvim'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gits='git status'
alias pacman='sudo pacman'
alias doom='$HOME/.config/emacs/bin/doom'
export PATH="$HOME/.cargo/bin:$PATH"
alias clippy-dirty="$HOME/scripts/clippy-dirty"

# unix tools
alias ls='lsd'
alias cat='bat'
alias du='dust'
alias df='duf'
alias find='fd'
alias ping='gping --clear'

zoxide init fish | source
alias cd='z'

# tools helpers
alias cargo-all-checks='cargo fmt --all && cargo hack --feature-powerset clippy --all-targets --locked  -- -D warnings && cargo test --all-features -- --include-ignored --show-output'
alias cargo-ci-workflow='cargo fmt --all && cargo hack --feature-powerset clippy --all-targets --locked  -- -D warnings && cargo test --all-features -- --include-ignored --show-output && cargo bench --all-features'
alias cargo-clippy-fmt='cargo clippy --all-targets --locked --no-default-features -- -D warnings && cargo build --all-targets && cargo fmt --all' 
alias docker-rmi-untagged='docker rmi (docker images -a|grep "<none>"|awk \'$1=="<none>" {print $3}\') -f'
alias cargo-update-bins='cargo install (cargo install --list | egrep \'^[a-z0-9_-]+ v[0-9.]+:$\' | cut -f1 -d\' \')'
alias cargo-clean-all='find . -name Cargo.toml -type f -execdir cargo clean \;'

alias update-system='rustup update && pacman -Syyu && yay -Syyu && doom upgrade && cargo-update-bins'

alias vpn-c "expressvpn connect smart"
alias vpn-d "expressvpn disconnect"

# openssl build stuff
export OPENSSL_LIB_DIR="/usr/lib/openssl-1.0"
export OPENSSL_INCLUDE_DIR="/usr/include/openssl-1.0"

function prompt_login --description 'display user name for the prompt'
    if not set -q __fish_machine
        set -g __fish_machine
        set -l debian_chroot $debian_chroot

        if test -r /etc/debian_chroot
            set debian_chroot (cat /etc/debian_chroot)
        end

        if set -q debian_chroot[1]
            and test -n "$debian_chroot"
            set -g __fish_machine "(chroot:$debian_chroot)"
        end
    end

    # Prepend the chroot environment if present
    if set -q __fish_machine[1]
        echo -n -s (set_color yellow) "$__fish_machine" (set_color normal) ' '
    end

    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY; and set -q fish_color_host_remote
        set color_host $fish_color_host_remote
        echo -n -s (set_color $fish_color_user) "$USER" (set_color normal) @ (set_color $color_host) (prompt_hostname) (set_color normal)
    end
end

# Defined in /usr/share/fish/functions/fish_prompt.fish @ line 4
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end
