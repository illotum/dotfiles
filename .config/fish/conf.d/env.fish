set -gx EDITOR hx
set -gx XDG_CONFIG_HOME $HOME/.config

test (command -v zoxide); and zoxide init fish | source
test (command -v mise); and mise activate fish | source
test (command -v direnv); and direnv hook fish | source

alias y "git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME"

abbr ts tailscale
abbr g git
abbr vi hx
abbr c curl -LO -C -
abbr bazel bazelisk
abbr myaws "aws --profile my"
abbr mycdk "cdk --profile my"
abbr kcat "kitten icat"
abbr kssh "kitten ssh"
