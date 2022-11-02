set --erase fish_greeting

fish_add_path $HOME/bin

fish_add_path $HOME/rabbit/server/bazel-bin/broker-home/sbin/

set -U EDITOR nvim

alias g git
alias y "/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME"
alias vi nvim

alias myaws "aws --profile my"
alias mycdk "cdk --profile my"

alias rs "rg -g '!**/build/**' -g '!**/env/**' -g '!**/node_modules/**' -g '!**/site-packages/**' -g '!**/release-info/**'"
alias fs "find -type d \( -path '*/release-info/*' -o -path '*/build/*' -o -path '*/env/*' -o -path '*/node_modules/*' -o -path '*/site-packages/*' \) -prune -o"

alias rge "rg -g '!**/test/**' -g '!**/examples/**' -g '**/src/**' -g '**/include/**' -g '!*SUITE*' -g '*.erl' -g '*.hrl'"

alias bazel bazelisk
alias perf-test "./bin/runjava com.rabbitmq.perf.PerfTest"
