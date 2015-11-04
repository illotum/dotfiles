set --erase fish_greeting

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
set fish_custom $HOME/.config/fish/custom

# Load oh-my-fish configuration.
source $fish_path/oh-my-fish.fish

# Dev variables
setenv GOPATH $HOME/go
setenv ARCHFLAGS '-arch x86_64'
setenv EDITOR vim
set fish_user_paths $GOPATH/bin

# GPG startup
# set -x GPG_TTY (tty)
# if not set -q GPG_AGENT_INFO
#     set -gx GPG_AGENT_INFO (gpg-agent --daemon | cut -d';' -f1 | cut -d'=' -f 2)
# end

# # set fish_user_paths /opt/chefdk/bin $fish_user_paths
# set -x GEM_ROOT /opt/chefdk/embedded/lib/ruby/2.1.0
# set -x GEM_HOME $HOME/.chefdk/gem/ruby/2.1.0
# set -x GEM_PATH $GEM_HOME $GEM_ROOT

# Theme
Theme "cmorrell.com"
set default_user illtm

# Plugins
Plugin "theme"
Plugin "brew"
Plugin "osx"
Plugin "replace"
Plugin "tmux"
Plugin "balias"
Plugin "gi"

# Aliases
balias gws "git status --short"
balias gc "git commit"
balias gca "git commit -a"
balias gco "git checkout"
balias ga "git add"
balias gb "git branch"
balias gm "git merge"
balias gps "git push"
balias gpl "git pull"
balias vim "nvim"
