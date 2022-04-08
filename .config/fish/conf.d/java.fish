test -f /usr/libexec/java_home; or return

set -U JAVA_HOME (/usr/libexec/java_home)
fish_add_path $JAVA_HOME/bin
