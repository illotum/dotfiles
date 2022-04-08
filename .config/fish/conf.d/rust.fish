test (command -v rustc >/dev/null); or return

set -U RUSTSRC (rustc --print sysroot)/lib/rustlib/src/rust/src
set -U CARGO_INSTALL_ROOT $HOME

