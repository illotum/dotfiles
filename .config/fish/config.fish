fish_add_path /usr/local/sbin
fish_add_path $HOME/bin

fish_add_path $HOME/rabbit/server/bazel-bin/broker-home/sbin/

fish_add_path $HOME/.cache/rebar3/bin

set -U EDITOR hx

alias g git
alias y "/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME"
alias vi hx

alias myaws "aws --profile my"
alias mycdk "cdk --profile my"

alias rs "rg -g '!**/build/**' -g '!**/env/**' -g '!**/node_modules/**' -g '!**/site-packages/**' -g '!**/release-info/**'"
alias fs "find -type d \( -path '*/release-info/*' -o -path '*/build/*' -o -path '*/env/*' -o -path '*/node_modules/*' -o -path '*/site-packages/*' \) -prune -o"

alias icat "kitty icat"
