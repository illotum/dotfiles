#!/bin/sh
set -eu -o pipefail

if test $DARKMODE -eq 1; then
  ln -sf  ${HOME}/.config/helix/themes/solarized_dark.toml \
          ${HOME}/.config/helix/themes/solarized.toml
   /opt/homebrew/bin/kitten themes --reload-in=all Solarized Dark
elif test $DARKMODE -eq 0; then
  ln -sf  ${HOME}/.config/helix/themes/solarized_light.toml \
          ${HOME}/.config/helix/themes/solarized.toml
  /opt/homebrew/bin/kitten themes --reload-in=all Solarized Light
else
    echo "unexpected darkmode value: ${DARKMODE}"
    exit 1
fi
