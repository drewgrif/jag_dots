# If not running interactively, don't do anything 
[[ $- != *i* ]] && return 

stty -ixon # Disables ctrl-s and ctrl-q (Used To Pause Term) 

if command -v eza >/dev/null 2>&1; then
    alias l='eza -ll --color=always --group-directories-first'
    alias ls='eza -al --header --icons --group-directories-first'
elif command -v exa >/dev/null 2>&1; then
    alias l='exa -ll --color=always --group-directories-first'
    alias ls='exa -al --header --icons --group-directories-first'
fi

# Aliases
alias ..='cd ..' 
alias ...='cd ../..' 
alias install='sudo nala install'
alias update='sudo apt clean && sudo apt update'
alias upgrade='sudo nala upgrade && sudo apt autoremove --purge'
alias uplist='nala list --upgradable'
alias remove='sudo nala autoremove'
alias df='df -h'
alias free='free -h'
alias myip="hostname -I | awk '{print $1}'; curl -s ifconfig.me && echo ' external ip'"
alias x="exit"

# Dotfiles & Files
alias bs='micro ~/.bashrc'
alias reload='source ~/.bashrc'
alias v="nvim"
alias vv="nvim ."
alias e="micro"
alias g.="cd ~/.config"
alias gd="cd ~/Downloads"

# DWM aliases
alias gdw="cd ~/.config/suckless/dwm"
alias gds="cd ~/.config/suckless/slstatus"
alias remake="rm config.h && make && sudo make clean install"

# Git aliases
alias gp="git push -u origin main"
alias gsave="git commit -m 'save'"
alias gs="git status"
alias gc="git clone"

alias ff="fastfetch"

# Dunst
alias hi='pgrep -x dunst >/dev/null && notify-send "Hi there!" "Welcome to the jaglinux desktop! " -i ""'


# Add Color
alias egrep='grep --color=auto' 

export PATH="$HOME/scripts:$HOME/.local/bin:/usr/local/go/bin:$PATH"
export EDITOR=$(command -v nvim || command -v micro || echo nano)
export VISUAL="$EDITOR"

# PS1 Customization
#PS1="\[\e[32m\]\h\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[34m\]\u\[\e[m\] \W \$ " 
# Colour codes
RED="\\[\\e[1;31m\\]"
GREEN="\\[\\e[1;32m\\]"
YELLOW="\\[\\e[1;33m\\]"
BLUE="\\[\\e[1;34m\\]"
MAGENTA="\\[\\e[1;35m\\]"
CYAN="\\[\\e[1;36m\\]"
WHITE="\\[\\e[1;37m\\]"
ENDC="\\[\\e[0m\\]"

# Set a two-line prompt. If accessing via ssh include 'ssh-session' message.
if [[ -n "$SSH_CLIENT" ]]; then ssh_message="-ssh_session"; fi
PS1="${MAGENTA}\t ${GREEN}\u ${WHITE}at ${YELLOW}\h${RED}${ssh_message} ${WHITE}in ${BLUE}\w \n${CYAN}\$${ENDC} "

