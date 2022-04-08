set -U GOPRIVATE "*"
set -U GOBIN $HOME/bin

alias rgg "rg --iglob '*.go' --iglob '!vendor/**'"
