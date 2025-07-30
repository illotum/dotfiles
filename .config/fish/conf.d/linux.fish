test (uname) = Linux; or return

fish_add_path /usr/share/bcc/tools/
fish_add_path $HOME/.local/bin

set -xg TMPDIR /tmp
set -xg GOOGLE_APPLICATION_CREDENTIALS $HOME/.config/gcloud/application_default_credentials.json
