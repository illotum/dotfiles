test (command -v $HOME/.cargo/bin/rustc >/dev/null); or return
set -gx CARGO_INSTALL_ROOT $HOME
fish_add_path $HOME/.cargo/bin
