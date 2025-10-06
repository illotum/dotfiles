set -gx GOPRIVATE "bitbucket.surfcrew.com,gitlab.menloinfra.com"
set -gx GOPROXY "https://oauth2accesstoken:$(gcloud auth print-access-token)@us-west1-go.pkg.dev/fond-giraffe-1d7l/go,https://proxy.golang.org,direct"
set -gx GOBIN $HOME/bin
fish_add_path $HOME/bin

test (uname) = Linux; or return
fish_add_path /usr/local/go/bin
