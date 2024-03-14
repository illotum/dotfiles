test (uname) = "Darwin"; or return

set -U HOMEBREW_CASK_OPTS "--appdir=~/Applications"

fish_add_path /usr/local/opt/make/libexec/gnubin
fish_add_path /usr/local/opt/findutils/libexec/gnubin
fish_add_path /usr/local/opt/openssl/bin
fish_add_path /Applications/Emacs.app/Contents/MacOS/bin
fish_add_path /usr/local/lib

alias emacs="emacs -nw" # Always launch "emacs" in terminal mode.
alias fs "fd -E build -E env -E node_modules -E site-packages -E release-info"

set brew_asdf_path (brew --prefix asdf)
if test -f $brew_asdf_path/libexec/asdf.fish
  source $brew_asdf_path/libexec/asdf.fish
end

set -x JAVA_HOME (/usr/libexec/java_home -v1.20)
fish_add_path $JAVA_HOME/bin


alias perf-test "/Users/valiushk/rabbit/bench/bin/runjava com.rabbitmq.perf.PerfTest"
