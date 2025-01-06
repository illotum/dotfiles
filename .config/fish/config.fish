fish_add_path $HOME/.nix-profile/bin
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

set -a fish_complete_path $HOME/.nix-profile/share/fish/completions/

set -gx EDITOR hx
set -gx XDG_CONFIG_HOME $HOME/.config

alias y "git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME"
abbr g git
abbr vi hx
abbr c curl -LO -C -
abbr bazel bazelisk
abbr myaws "aws --profile my"
abbr mycdk "cdk --profile my"
abbr kcat "kitten icat"
abbr kssh "kitten ssh"
abbr wssh "wezterm ssh"
abbr wcat "wezterm imgcat"
