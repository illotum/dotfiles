set -gx EDITOR hx
set -gx XDG_CONFIG_HOME $HOME/.config

test (command -v zoxide); and zoxide init fish | source
test (command -v mise); and mise activate fish | source

set -gx GOOGLE_CLOUD_PROJECT gemini-ai-sandbox

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
