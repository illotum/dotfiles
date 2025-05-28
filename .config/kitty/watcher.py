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
    with Path.home() / ".config" / "helix" / "themes" as path:
        link_path = str(path / "solarized.toml")
        if data['is_dark']:
            theme_path = str(path / "solarized_dark.toml")
        else:
            theme_path = str(path / "solarized_light.toml")
        if os.path.isfile(link_path):
            os.remove(link_path)
        os.symlink(theme_path, link_path)
