#!/bin/sh
set -eu -o pipefail

if test $DARKMODE -eq 1; then
  ln -sf  ${HOME}/.config/helix/themes/solarized_dark.toml \
          ${HOME}/.config/helix/themes/solarized.toml
  kitty +kitten themes --reload-in=all Solarized Dark
else
  ln -sf  ${HOME}/.config/helix/themes/solarized_light.toml \
          ${HOME}/.config/helix/themes/solarized.toml
  kitty +kitten themes --reload-in=all Solarized Light
fi
