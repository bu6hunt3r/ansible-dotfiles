source <(antibody init)
antibody bundle < ~/.zsh_plugins

# bind UP and DOWN arrow keys
for keycode in '[' '0'; do
bindkey "^[${keycode}A" history-substring-search-up
  bindkey "^[${keycode}B" history-substring-search-down
done
unset keycode

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# Aliases and functions
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'

# Commands and builtins
ZSH_HIGHLIGHT_STYLES[command]="fg=green"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=green,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=green,bold"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=green,underline"
ZSH_HIGHLIGHT_STYLES[commandseparator]="none"

# Paths
ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'

# Globbing
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow,bold'

# Options and arguments
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=red'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'

ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=green"

# Patterns
ZSH_HIGHLIGHT_PATTERNS+=('mv *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo ' 'fg=white,bold')

source ~/.zbindkeys

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

setopt nobeep                  # i hate beeps
setopt alwaystoend             # when complete from middle, move cursor
setopt autopushd               # automatically append dirs to the push/pop list
setopt cdablevars              # avoid the need for an explicit $
setopt correct_all             # correct all the words in the command line
setopt noflowcontrol           # if I could disable Ctrl-s completely I would!
setopt RM_STAR_WAIT            # confirmation after 'rm *' etc..

autoload -U compinit
compinit
zmodload zsh/complist

setopt completealiases         # complete alisases
setopt extendedglob            # weird & wacky pattern matching - yay zsh!
setopt nolisttypes             # show types in completion
setopt autolist                # filename completion
setopt listpacked              # compact completion lists
setopt MARK_DIRS               # Append a trailing `/' to all directory names resulting from filename generation (globbing).
setopt completeinword          # not just at the end

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[0;33m%} %B%d%b%{\e[0m%}'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:default' list-prompt'%S%M matches%s'
zstyle ':completion:*:prefix:*' add-space true

zstyle ':completion:*:paths' accept-exact '*(N)'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' rehash true

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' menu select=2

zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=34=36"

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $(whoami) -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

export TIMEFMT="%U user %S system %P cpu %*E total, running %J"
REPORTTIME=10

setopt autocd                   # change to dirs without cd
setopt pushd_to_home            # Push to home directory when no argument is given.
setopt auto_pushd               # Push the old directory onto the stack on cd.
setopt auto_name_dirs           # Auto add variable-stored paths to ~ list.
setopt pushd_ignore_dups        # Do not store duplicates in the stack.

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history     # Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history   # Include more information about when the command was executed, etc
setopt hist_ignore_dups   # Ignore duplication command history list
setopt hist_reduce_blanks # Remove extra blanks from each command line being added to history
setopt inc_append_history # Add comamnds as they are typed, don't wait until shell exit'
setopt hist_find_no_dups  # When searching history don't display results already cycled through twice'
setopt share_history      # Share command history data

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"
bindkey '^f' vi-forward-blank-word

eval `dircolors ~/.dircolors`

alias ls='ls --color=auto --group-directories-first -X'
alias l='ls -lh'
alias la='l -A'

alias c='clear'
alias q='exit'
alias b='builtin cd ..'

alias w='echo -e "$Blue ${"$(pwd)"/$HOME/~} ${Red}at ${Cyan}$(whoami)${Red}@${Yellow}$(hostname -s)$Red \
using $Yellow${0}$Purple ${DOT_PROMPT_CHAR:-$}${Rst}"'

alias tarc='tar -zcvf'
alias tarx='tar -zxvf'

if [[ -x $(command -v xclip) ]]; then
    alias xsl='xclip -selection clipboard'
fi

if [[ -z `command grc` ]]; then
    echo "grc is not installed. grc aliases will be ignored."
else
    alias irclog="grc irclog"
    alias log="grc log"
    alias configure="grc configure"
    alias ping="grc ping"
    alias traceroute="grc traceroute"
    alias gcc="grc gcc"
    alias netstat="grc netstat"
    alias stat="grc stat"
    alias ss="grc ss"
    alias diff="grc diff"
    alias wdiff="grc wdiff"
    alias last="grc last"
    alias ldap="grc ldap"
    alias cvs="grc cvs"
    alias mount="grc mount"
    alias findmnt="grc findmnt"
    alias mtr="grc mtr"
    alias ps="grc ps"
    alias dig="grc dig"
    alias ifconfig="grc ifconfig"
    alias mount="grc mount"
    alias df="grc df"
    alias du="grc du"
    alias ipaddr="grc ipaddr"
    alias iproute="grc iproute"
    alias ipneighbor="grc ipneighbor"
    alias ip="grc ip"
    alias env="grc env"
    alias iptables="grc iptables"
    alias lspci="grc lspci"
    alias lsblk="grc lsblk"
    alias lsof="grc lsof"
    alias blkid="grc blkid"
    alias id="grc id"
    alias iostat_sar="grc iostat_sar"
    alias fdisk="grc fdisk"
    alias free="grc free"
    alias findmnt="grc findmnt"
    alias log="grc log"
    alias systemctl="grc systemctl"
    alias sysctl="grc sysctl"
    alias tcpdump="grc tcpdump"
    alias tune2fs="grc tune2fs"
    alias lsmod="grc lsmod"
    alias lsattr="grc lsattr"
    alias semanageboolean="grc semanageboolean"
    alias semanagefcontext="grc semanagefcontext"
    alias semanageuser="grc semanageuser"
    alias getsebool="grc getsebool"
    alias ulimit="grc ulimit"
    alias vmstat="grc vmstat"
    alias dnf="grc dnf"
    alias nmap="grc nmap"
    alias uptime="grc uptime"
    alias getfacl="grc getfacl"
    alias ntpdate="grc ntpdate"
    alias showmount="grc showmount"
    alias ant="grc ant"
    alias mvn="grc mvn"
    alias iwconfig="grc iwconfig"
    alias lolcat="grc lolcat"
    alias whois="grc whois"
fi

alias pacman='pacman --color=always'
alias pachist="awk -F' ' /\(starting\|upgraded\|downgraded\|installed\)/'{print \$1,\$2,\$5,\$6,\$7,\$8}' /var/log/pacman.log | sed 's/.*full.*//'"
alias pac_mirror_update='sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup+`date +"%m-%d-%y"`; sudo reflector -l 10 --sort rate --save /etc/pacman.d/mirrorlist'

alias ctl='sudo systemctl'
startd() { ctl start $1.service; ctl status $1.service; }
stopd() { ctl stop $1.service; ctl status $1.service; }
restartd() { ctl restart $1.service; ctl status $1.service; }
statusd() { ctl status $1.service; }
enabled() { ctl enable $1.service; listd; }
disabled() { ctl disable $1.service; listd; }

alias journalctl-error='sudo journalctl -b --priority 0..3'

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'
alias sudo='nocorrect sudo'

alias myip='curl ifconfig.me'
alias fw='sudo iptables -L'
alias myserver='python -m SimpleHTTPServer 8000'

setopt prompt_subst

autoload -U colors && colors

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '$'
}

function git_branch {
    BRANCH="$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)"
    if ! test -z $BRANCH; then
        COL="%{$fg[green]%}" # Everything's fine
        [[ $(git log origin/master..HEAD 2> /dev/null ) != "" ]] && COL="%{$fg[red]%}" # We have changes to push
        [[ $(git status --porcelain 2> /dev/null) != "" ]] && COL="%{$fg[yellow]%}" # We have uncommited changes
        echo "%{$fg[green]%}(%{$fg[cyan]%}$(prompt_char) $COL$BRANCH%{$fg[green]%})"
    fi
}

PROMPT='$(git_branch)%{$fg[green]%}(%~)%{$reset_color%}%# '
RPROMPT="%(?,%{$fg[green]%};%),%{$fg[red]%};()%f"
#RPROMPT="%{$fg[green]%}%T%{$reset_color%}"
SPROMPT="Correct %{$fg[red]%}%R to %{$fg[green]%}%r?%{$reset_color%} ([%{$fg[green]%}Y%{$reset_color%}]es/[%{$fg[red]%}N%{$reset_color%}]o/[%{$fg[yellow]%}E%{$reset_color%}]dit/[%{$fg[red]%}A%{$reset_color%}]bort) "

bindkey -e
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
#bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line
bindkey ' ' magic-space
bindkey '^[[Z' reverse-menu-complete
bindkey '^?' backward-delete-char
bindkey '^[[1;3C' forward-kill-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

pk () {
    if [ $1 ] ; then
        case $1 in
            tbz) tar cjvf $2.tar.bz2 $2 ;;
            tgz) tar czvf $2.tar.gz $2 ;;
            tar) tar cpvf $2.tar $2 ;;
            bz2) bzip $2 ;;
            gz) gzip -c -9 -n $2 > $2.gz ;;
            zip) zip -r $2.zip $2 ;;
            7z) 7z a $2.7z $2 ;;
            *) echo "'$1' cannot be packed via pk()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1 ;;
            *.tar.gz) tar xvzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xvf $1 ;;
            *.tbz2) tar xvjf $1 ;;
            *.tgz) tar xvzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "don't know how to extract '$1′…" ;;
        esac
     else
        echo "'$1′ is not a valid file!"
     fi
}

orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo no orphans to remove
    else
        sudo pacman -Rs $(pacman -Qdtq)
    fi
}

if command -v colordiff > /dev/null 2>&1; then
    alias diff="colordiff -Nuar"
else
    alias diff="diff -Nuar"
fi
