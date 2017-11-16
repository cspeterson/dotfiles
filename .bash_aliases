# Aliases and functions

# Generally-useful aliases
alias axfr='dig AXFR' # Zone transfer
alias clr='clear'
alias digs='dig +short' # reduce dig output
alias duhso='du -h | sort -Vr | head' # Human-readable disk usage top offenders in curr dir
alias duso='du | sort -Vr | head' # Disk usage top offenders in curr dir
alias egrep='grep  --exclude-dir=".svn"--exclude-dir=".git" -E'
alias fgrep='grep --exclude-dir=".svn" --exclude-dir=".git" -F'
alias grep='grep  --exclude-dir=".svn"--exclude-dir=".git"'
alias grepi='grep --exclude-dir=".svn"--exclude-dir=".git" -i' # case-insensitive grep
alias ll='ls -l'
alias lla='ls -la'
alias llz='ls -lZ'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'" # For REALLY improtant security things
alias sortip='sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4' # Sort ip addresses

# Aliases rather particular to my use-case
alias locksleep='sudo echo sudo && sudo -u csp i3lock -I 10 && sudo pm-suspend'

# Functions
dossh() {
        ssh "$1"
        until [ $? -eq 0 ]; do
                sleep 1; ssh "$1"
        done
}
