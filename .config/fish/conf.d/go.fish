set -gx GOPRIVATE "bitbucket.surfcrew.com"
set -gx GOPROXY "https://artifactory.menloinfra.com/artifactory/api/go/go-dev"
set -gx GOBIN $HOME/bin
fish_add_path $HOME/bin

test (uname) = Linux; or return
fish_add_path /usr/local/go/bin
