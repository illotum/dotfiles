set --erase fish_greeting
set -g fish_user_paths $HOME/.toolbox/bin $HOME/bin $HOME/.cargo/bin /usr/local/sbin /usr/local/opt/make/libexec/gnubin /usr/local/opt/openssl/bin >/dev/null 2>/dev/null or true

# Dev variables
set -xg ARCHFLAGS '-arch x86_64'
set -xg EDITOR nvim
set -g HOMEBREW_CASK_OPTS "--appdir=~/Applications"
# set -xg RUSTSRC (rustc --print sysroot)/lib/rustlib/src/rust/src 2>/dev/null or true
set -xg GOPRIVATE "gitlab.whiteops.com/*"
set -xg GOBIN $HOME/bin
set -xg GO111MODULE on
set -xg CARGO_INSTALL_ROOT $HOME
set -xg DOCKER_HOST_IP 127.0.0.1
set -xg MANPATH (manpath) /usr/local/opt/erlang/lib/erlang/man
set -xg NVM_DIR "$HOME/.nvm"

# NVM
load_nvm


source $HOME/.config/fish/private-config.fish >/dev/null 2>/dev/null or true

# Aliases
alias g git
alias y '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vi nvim
alias vis vise
alias myaws "aws --profile my"
alias mycdk "cdk --profile my"
alias rgg "rg --iglob '*.go' --iglob '!vendor'"
alias tmux "tmux -2"
alias venv "source ./env/bin/activate.fish"
alias y '/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'


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
