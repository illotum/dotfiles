set --erase fish_greeting

# Dev variables
set -Ux GOPATH $HOME/go
set -Ux RUSTSRC (rustc --print sysroot)/lib/rustlib/src/rust/src
set -Ux GOBIN $HOME/bin
# set -Ux GO111MODULE on
set -Ux ARCHFLAGS '-arch x86_64'
set -Ux EDITOR vi
set -Ux HOMEBREW_CASK_OPTS "--appdir=~/Applications"

set -U fish_user_paths /usr/local/opt/openssl/bin $HOME/bin $HOME/.cargo/bin $HOME/bin/FlameGraph > /dev/null 2> /dev/null or true

source $HOME/.config/fish/private-config.fish > /dev/null 2> /dev/null or true
source $HOME/erls/18.1.5a/activate.fish > /dev/null 2> /dev/null or true

# Command mode
# fish_vi_key_bindings

# Aliases
alias g "git"
alias y "yadm"
alias vi "nvim"
alias vis "vise"
alias rgg "rg --iglob '*.go' --iglob '!vendor'"

function tmux
  command tmux -2 $argv
end

function speedtest
  command echo (date) // (speedtest-cli --simple | sed 'N;s/\n/, /g') >> $HOME/speedtest.log
end

# Maintain a persistent Tmux session
if not set -q TMUX; and not set -q SSH_CONNECTION; and [ $TERM = 'xterm-256color' ]
    set tmux_session fish

    if not tmux has-session ^/dev/null
        tmux \
            start-server \; \
            new-session -d -s "$tmux_session" \; \
            set-option -t "$tmux_session" destroy-unattached off >/dev/null ^/dev/null
    end
    exec tmux attach-session
end
