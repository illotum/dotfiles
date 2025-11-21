set -gx GOPRIVATE "bitbucket.surfcrew.com,gitlab.menloinfra.com"
set -gx GOBIN $HOME/bin
fish_add_path $HOME/bin

test (uname) = Linux; or return
fish_add_path /usr/local/go/bin
