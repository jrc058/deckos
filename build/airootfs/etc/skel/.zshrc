# DeckOS ZSH Configuration
# Optimized for handheld/cyberdeck use

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Completion
autoload -Uz compinit
compinit

# Prompt (simple and clean for small screens)
PROMPT='%F{cyan}%n@deckos%f:%F{yellow}%~%f$ '

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'

# DeckOS specific
alias gamemode='systemctl --user start plasma-mobile-session.target'
alias devmode='sway'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias wifi='nmtui'

# Enable syntax highlighting if available
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Enable auto-suggestions if available
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
