fish_add_path $HOME/.nix-profile/bin
fish_add_path $HOME/bin

set -gx EDITOR hx
set -gx XDG_CONFIG_HOME $HOME/.config

alias y "git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME"
abbr g git
abbr vi hx
abbr bazel bazelisk
abbr myaws "aws --profile my"
abbr mycdk "cdk --profile my"
abbr icat "kitten icat"
abbr kssh "kitten ssh"
