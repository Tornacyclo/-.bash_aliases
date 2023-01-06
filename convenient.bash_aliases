# Eliminate comments from a file
alias cgrep="grep -E -v '^(#|$|;)'"
alias nocomment='cgrep'


# cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak 
function cpb() { cp $@{,.bak} ;}

# Backup the file passed as parameter, adding the date and time
function bak() { cp "$1" "$1_`date +%Y-%m-%d_%H-%M-%S`" ; }
alias bak="bak"
alias back="bak"


# Be nice to system resources
function nicecool() {
    if ! [ -z "$1" ] 
    then
        # Take pid as parameter
        ionice -c3 -p$1 ; renice -n 19 -p $1
    else
        # If no parameter, nice current pid (bash)
        ionice -c3 -p$ ; renice -n 19 -p $
    fi
}
alias niceprod="nicecool"
alias np="niceprod"


function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
alias extract="extract"
alias unall="extract"


# Ban an IP quickly
function ban() {
    if [ "`id -u`" == "0" ] ; then
        iptables -A INPUT -s $1 -j DROP
    else
        sudo iptables -A INPUT -s $1 -j DROP
    fi
}
alias ban="ban"


# Shortcuts:
alias q='exit'
alias maj='sudo aptitude update && sudo aptitude safe-upgrade'
alias c='clear'
alias rm='rm --interactive --verbose'
alias wget='wget -c'
alias mv='mv --interactive --verbose'
alias cp='cp --verbose'
alias grepr='grep -r'
alias grep='grep -i --color'
alias tree="find . | sed 's/[^/]*\//|   /g;s/| *\([^| ]\)/+--- \1/'"
alias mkdir='mkdir -pv'
alias pg='ps aux | grep'
alias pl='ps faux | less'
#function mkcd () { mkdir $1 && cd $1 }
function mkcd() { mkdir -p "$@" && cd "$_"; }
alias mkcd="mkcd"


alias rotate-exif='jhead -autorot' # rotate-exif *.JPG
alias 1024="mogrify -resize 1024x1024 *.JPG"


# Sources : 
#  - http://root.abl.es/methods/1504/automatic-unzipuntar-using-correct-tool/
#  - http://forum.ubuntu-fr.org/viewtopic.php?id=20437&p=3


if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
