set --erase fish_greeting
set -g fish_user_paths $HOME/bin $HOME/.cargo/bin /usr/local/opt/openssl/bin >/dev/null 2>/dev/null or true

# Dev variables
set -xg ARCHFLAGS '-arch x86_64'
set -xg EDITOR nvim
set -g HOMEBREW_CASK_OPTS "--appdir=~/Applications"
set -xg RUSTSRC (rustc --print sysroot)/lib/rustlib/src/rust/src
set -xg GOPRIVATE "gitlab.whiteops.com/*"
set -xg GOROOT "/usr/local/go"
set -xg GOBIN $HOME/bin
set -xg GO111MODULE on
set -xg CARGO_INSTALL_ROOT $HOME


source $HOME/.config/fish/private-config.fish >/dev/null 2>/dev/null or true

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
