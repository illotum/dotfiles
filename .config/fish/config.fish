set --erase fish_greeting

# Dev variables
setenv GOPATH $HOME
setenv ARCHFLAGS '-arch x86_64'
setenv EDITOR vi
setenv HOMEBREW_CASK_OPTS "--appdir=~/Applications"

set fish_user_paths $HOME/bin $HOME/bin/FlameGraph

source $HOME/.config/fish/private-config.fish > /dev/null 2> /dev/null or true
source $HOME/erls/18.1.5a/activate.fish > /dev/null 2> /dev/null or true

# Command mode
# fish_vi_key_bindings

# Aliases
alias g "git"
alias y "yadm"
alias vi "nvim"
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
