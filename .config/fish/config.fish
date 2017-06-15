set --erase fish_greeting

# Dev variables
setenv GOPATH $HOME
setenv ARCHFLAGS '-arch x86_64'
setenv EDITOR vi
setenv HOMEBREW_GITHUB_API_TOKEN a795a7ea872b891ed4b61702df7223637d7588bd
setenv HOMEBREW_CASK_OPTS "--appdir=~/Applications"
set fish_user_paths $HOME/bin /usr/local/sbin $HOME/.cargo/bin $HOME/FlameGraph $HOME/.cargo/bin
set default_user illtm

# Command mode
# fish_vi_key_bindings

# Aliases
alias gws "git status --short"
alias gc "git commit"
alias gca "git commit -a"
alias gco "git checkout"
alias ga "git add"
alias gb "git branch"
alias gm "git merge"
alias gps "git push"
alias gpl "git pull"
alias vi "nvim"

function tmux
  command tmux -2 $argv
end

function speedtest
  command echo (date) // (speedtest-cli --simple | sed 'N;s/\n/, /g') >> $HOME/speedtest.log
end

# Maintain a persistent Tmux session
if not set -q TMUX; and [ $TERM = 'xterm-256color' ]
    set tmux_session fish

    if not tmux has-session ^/dev/null
        tmux \
            start-server \; \
            new-session -d -s "$tmux_session" \; \
            set-option -t "$tmux_session" destroy-unattached off >/dev/null ^/dev/null
    end
    exec tmux attach-session
end
