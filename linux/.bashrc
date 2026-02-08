# ~/.bashrc
# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# Source ~/.profile if it exists (this gives you the same environment
# that a login shell would have)
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

eval "$(direnv hook bash)"

# Add exactly these lines to ~/.bashrc
_venv() {
    # First try the normal way
    if [ -n "$VIRTUAL_ENV" ]; then
        printf "(%s) " "$(basename "$VIRTUAL_ENV")"
    # Fallback for Alpine's python3 -m venv that doesn't set VIRTUAL_ENV
    elif [ -f ".venv/bin/activate" ] && [ -n "$BASH" ]; then
        printf "(.venv) "
    elif [ -f "venv/bin/activate" ] && [ -n "$BASH" ]; then
        printf "(venv) "
    fi
}

PROMPT_COMMAND='_v="$(_venv)"'

PS1='\[\e[38;5;208m\]${_v}\[\e[1;36m\]\u\[\e[0m\]@\[\e[1;32m\]\h\[\e[0m\]:\[\e[34m\]\w\[\e[1;37m\]\$\[\e[0m\] '

# Only run the fzf stuff if fzf is installed
if command -v fzf >/dev/null 2>&1; then
  # Ctrl-R → fzf interactive history search
  bind -x '"\C-r": "__fzf_history__"'
  # Optional: Up/Down arrows also trigger fzf history search
  bind -x '"\e[A": "__fzf_history__"' # Up
  bind -x '"\e[B": "__fzf_history__"' # Down

  __fzf_history__() {
    local selected
    selected=$(fc -l 1 |
               sed 's/^[[:space:]]*[0-9]*[[:space:]]*//' |
               fzf --tac --no-sort --query="${READLINE_LINE}" --height=40% --reverse)
    READLINE_LINE="${selected}"
    READLINE_POINT=${#READLINE_LINE}
  }
fi

# Silence "Display all N possibilities?" prompt (equivalent of zsh LISTMAX)
bind "set completion-query-items 10000"
bind "set page-completions off"
shopt -s no_empty_cmd_completion   # don’t try to complete empty lines

