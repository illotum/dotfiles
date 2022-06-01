alias tmux "tmux -2"

return # temp disabled
# Maintain a persistent tmux session over SSH
if not set -q TMUX; and set -q SSH_CONNECTION; and [ $TERM = 'xterm-256color' ]
    set tmux_session fish
    if not tmux has-session 2>/dev/null
        tmux \
            start-server \; \
            new-session -d -s "$tmux_session" \; \
            set-option -t "$tmux_session" destroy-unattached off >/dev/null 2>/dev/null
    end
    exec tmux attach-session
end
