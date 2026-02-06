alias node='bun'
alias l='lsd -l'
alias la='lsd -la'
alias lt='lsd --tree'
alias c='clear'

# --- Git Speed Suite ---
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
alias gcam='git add -A && git commit -m' # Stage all and commit in one go
alias gr='git commit --amend -m'         # Fix the last commit message
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gcb='git checkout -b'               # Create and switch to new branch
alias gb='git branch'
alias gundo='git reset --soft HEAD~1'     # Undo last commit but keep changes staged

# --- Git Visuals (Ruby Slate Theme) ---
# gl: Shows a beautiful graph with Ruby Red author names
alias gl="git log --graph --pretty=format:'%C(auto)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold #991b1b)<%an>%Creset' --abbrev-commit"

# gbl: Lists branches with a Berry Red highlight and relative dates
alias gbl='git branch --format="%(color:bold #be123c)%(refname:short)%(color:reset) - %(contents:subject) %(color:#5c6370)(%(committerdate:relative))"'

# bun completions
[ -s "/Users/rafal/.bun/_bun" ] && source "/Users/rafal/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Ruby & Neovim
export PATH="$HOME/.rbenv/bin:$HOME/Applications/nvim/bin:$PATH"
eval "$(rbenv init - zsh)"

. "$HOME/.cargo/env"

eval "$(starship init zsh)"

# Set Directory colors to Ruby Red (#991b1b is approx ANSI 124 or 160)
# 'di' is directory, '01;38;5;160' is bold Ruby Red
export LS_COLORS="di=01;38;5;160:ex=01;38;5;197"

