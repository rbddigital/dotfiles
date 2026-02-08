# ~/.profile
# ensures your Bash-specific interactive settings (~/.bashrc) are loaded when you log in (a "login shell"),
# while preventing it from being loaded multiple times (recursion) if your files source each other.
if [ -n "$BASH_VERSION" ]; then
    # Only source .bashrc if it hasn't been sourced already by the login shell
    if [ -f "$HOME/.bashrc" ] && [[ -z "$BASHRC_SOURCED" ]]; then 
        export BASHRC_SOURCED=1 # Set a flag to prevent recursion
        . "$HOME/.bashrc"
    fi
fi

# ────────────────────────────── ~/.profile ──────────────────────────────
# This file is read once at login – perfect for environment variables

# History file persisted on macOS side (survives container deletion)
export HISTFILE="/Users/$(whoami)/.bash_history_alpine"

# Size of history
export HISTSIZE=10000
export HISTFILESIZE=50000

# Behaviour
export HISTCONTROL="ignoredups:ignorespace:erasedups"

# Never record dangerous rm commands
export HISTIGNORE="rm *:rf *:rm -rf*:rm -r*:sudo rm*:sudo rm -rf*:sudo rm -r*:*rm -rf *:*rm -r *"

# Show timestamps in `history` output
export HISTTIMEFORMAT="%F %T  "

# general aliases
alias ls='lsd -l'
alias l='ls -lh'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias z="zellij"
alias reload="source ~/.profile"

# python3 aliases
alias wp='which python3'
alias pip='uv pip'
alias python='python3.12'
alias venv="uv venv --seed"
alias pgsql="psql -U postgres"
alias ipy='ipython'

# git aliases
alias ga='git add'
alias gaa='ga -A'
alias gap='ga --patch'
alias gb='git branch'
alias gba='gb --all'
alias gc='git commit'
alias gca='gc --amend --no-edit'
alias gce='gc --amend'
alias gco='git checkout'
alias gcl='git clone --recursive'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gds='gd --staged'
alias gi='git init'
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n"'
alias gm='git merge'
alias gbn='git checkout -b'  # new branch
alias gp='git push'
alias gs='git status --short'
alias gu='git pull'

# --------------------------------------------------------------------
# gcm() - Quick Commit Function (Git Commit Message)
# Usage: gcm "Your commit message here"
# --------------------------------------------------------------------
gcm() {
    # 1. Check if a commit message was provided
    if [ $# -eq 0 ]; then
        echo "Error: Please provide a commit message."
        echo "Usage: gcm \"Your commit message here\""
        return 1
    fi

    # 2. Execute the commit command
    # "$@" ensures all arguments (if you had multiple words) are passed
    # correctly as a single, quoted string to the --message flag.
    git commit --message "$@"
}

# --------------------------------------------------------------------
# Optional: gcam() - Quick Add and Commit All
# Usage: gcam "Your commit message here"
# This function automatically runs 'git add -A' before committing.
# WARNING: Use with caution, as it stages all changes automatically.
# --------------------------------------------------------------------
gcam() {
    if [ $# -eq 0 ]; then
        echo "Error: Please provide a commit message for gcam."
        echo "Usage: gcam \"Your commit message here\""
        return 1
    fi

    echo ">>> Running 'git add -A'..."
    git add -A

    echo ">>> Committing changes..."
    # Reuse the gcm logic for the final commit
    git commit --message "$@"
}

# docker aliases
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dl='docker logs --tail=100'
alias dc='docker compose'

# neovim
alias n="nvim"

# export env variables
export TERM="xterm-256color"
export NVIM_LOG_FILE="$HOME/neovim_log.txt"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.local/bin/env"
. "$HOME/.cargo/env"

