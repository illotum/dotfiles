test (uname) = "Linux"; or return

fish_add_path /usr/share/bcc/tools/
fish_add_path /usr/local/go/bin

set -xg TMPDIR /tmp

if test -f ~/.asdf/asdf.fish
	source ~/.asdf/asdf.fish
end
