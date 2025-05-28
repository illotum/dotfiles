test (command -v rustc >/dev/null); or return
set -gx RUSTSRC (rustc --print sysroot)/lib/rustlib/src/rust/src
set -gx CARGO_INSTALL_ROOT $HOME
fish_add_path $HOME/.cargo/bin
