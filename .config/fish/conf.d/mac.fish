test (uname) = "Darwin"; or return

set -U HOMEBREW_CASK_OPTS "--appdir=~/Applications"

fish_add_path /usr/local/opt/make/libexec/gnubin
fish_add_path /usr/local/opt/openssl/bin

set brew_asdf_path (brew --prefix asdf)
if test -f $brew_asdf_path/libexec/asdf.fish
	source $brew_asdf_path/libexec/asdf.fish
end
