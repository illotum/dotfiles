set --erase fish_greeting

# Dev variables
set -g GOPATH $HOME/go
set -g RUSTSRC (rustc --print sysroot)/lib/rustlib/src/rust/src
set -g GOBIN $HOME/bin
set -g ARCHFLAGS '-arch x86_64'
set -g EDITOR vi
set -g HOMEBREW_CASK_OPTS "--appdir=~/Applications"

set -g fish_user_paths $HOME/bin $HOME/.cargo/bin $HOME/bin/FlameGraph /usr/local/opt/openssl/bin /usr/local/opt/node@10/bin $HOME/.emacs.d/bin > /dev/null 2> /dev/null or true

source $HOME/.config/fish/private-config.fish > /dev/null 2> /dev/null or true

# Aliases
alias g "git"
alias y "yadm"
alias vi "nvim"
alias vis "vise"
alias rgg "rg --iglob '*.go' --iglob '!vendor'"
alias tmux "tmux -2"
alias venv "source ./env/bin/activate.fish"

# Maintain a persistent tmux session
# if not set -q TMUX; and not set -q SSH_CONNECTION; and [ $TERM = 'xterm-256color' ]
#     set tmux_session fish
#     if not tmux has-session 2>/dev/null
#         tmux \
#             start-server \; \
#             new-session -d -s "$tmux_session" \; \
#             set-option -t "$tmux_session" destroy-unattached off >/dev/null 2>/dev/null
#     end
#     exec tmux attach-session
# end
