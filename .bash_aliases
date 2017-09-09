# Aliases and functions

alias axfr='dig AXFR' # Zone transfer
alias clr='clear'
alias digs='dig +short' # reduce dig output
alias duhso='du -h | sort -Vr | head' # Human-readable disk usage top offenders in curr dir
alias duso='du | sort -Vr | head' # Disk usage top offenders in curr dir
alias egrep='egrep  --exclude-dir=".svn"--exclude-dir=".git"'
alias fgrep='fgrep --exclude-dir=".svn" --exclude-dir=".git"'
alias grep='grep  --exclude-dir=".svn"--exclude-dir=".git"'
alias grepi='grep -i' # case-insensitive grep
alias ll='ls -l'
alias lla='ls -la'
alias llz='ls -lZ'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'" # For REALLY improtant security things
alias sortip='sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4' # Sort ip addresses

# Functions
dossh() {
        ssh "$1"
        until [ $? -eq 0 ]; do
                sleep 1; ssh "$1"
        done
}
