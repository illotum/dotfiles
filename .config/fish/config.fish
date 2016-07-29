set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish
set --erase fish_greeting

# Dev variables
setenv GOPATH $HOME/go
setenv ARCHFLAGS '-arch x86_64'
setenv EDITOR vim
set fish_user_paths $GOPATH/bin /usr/local/sbin
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
alias vim "nvim"
alias kube "kubectl"
alias skube "kubectl --namespace=kube-system"
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

if [ $TERM = 'eterm-color' ]
    tic -o ~/.terminfo $TERMINFO/e/eterm-color.ti
end

# GPG startup
# set -x GPG_TTY (tty)
# if not set -q GPG_AGENT_INFO
#     set -gx GPG_AGENT_INFO (gpg-agent --daemon | cut -d';' -f1 | cut -d'=' -f 2)
# end


alias how2='docker run -it --rm gdraynz/how2'
