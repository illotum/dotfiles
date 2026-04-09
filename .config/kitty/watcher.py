from typing import Any

from kitty.boss import Boss
from kitty.window import Window

import os
from pathlib import Path

def on_color_scheme_preference_change(boss: Boss, window: Window, data: dict[str, Any]) -> None:
    # Called when the color scheme preference of this window changes from
    # light to dark or vice versa. data contains is_dark and via_escape_code
    # the latter will be true if the color scheme was changed via escape
    # code received from the program running in the window
    with open(Path.home() / ".config" / "helix" / "themes" / "solarized.toml") as f:
        theme = "solarized_light"
        if data['is_dark']:
            theme = "solarized_dark"
        f.write(f"inherits = '{theme}'\n")
