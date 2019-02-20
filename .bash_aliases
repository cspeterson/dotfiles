# Aliases and functions

#
# Generally-useful aliases
#
alias axfr='dig AXFR' # Zone transfer
alias be='bundler exec'
alias cd..='cd ..' # I typo this often
alias clip='xclip -selection clipboard' # Put input to x primary clipboard
alias clr='clear'
alias digs='dig +short' # reduce dig output
alias duhso='du -h | sort -Vr | head' # Human-readable disk usage top offenders in curr dir
alias duso='du | sort -Vr | head' # Disk usage top offenders in curr dir
alias egrep='grep  --exclude-dir=".svn"--exclude-dir=".git" -E'
alias egrpe='grep  --exclude-dir=".svn"--exclude-dir=".git" -E' # I always frickin' do that
alias ffmpeg='ffmpeg -hide_banner' # Hide the giant dump that ffmpeg does on each run by default
alias fgrep='grep --exclude-dir=".svn" --exclude-dir=".git" -F'
alias fgrpe='grep --exclude-dir=".svn" --exclude-dir=".git" -F' # I always frickin' do that
alias grep='grep  --exclude-dir=".svn"--exclude-dir=".git"'
alias grpe='grep  --exclude-dir=".svn"--exclude-dir=".git"' # I always frickin' do that
alias grepi='grep --exclude-dir=".svn"--exclude-dir=".git" -i' # case-insensitive grep
alias jql='jq -C "." | less -FR' # Pipe jq directly into less with colors. Only paginate if longer than screen.
alias ll='ls -l'
alias lla='ls -la'
alias llz='ls -lZ'
alias less='less -XF' # X prevents clearing screen after and F ditches pagination if too short
alias nodeactivate='PATH=$(npm bin):$PATH; '
alias pythong='python' # Screw it I give up
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'" # For REALLY improtant security things
alias screen='TERM=screen-256color screen'
alias screenhere='screen -DRS "$(basename $(pwd))"'
alias shfmtg='shfmt -i 2 -ci' # shfmt by Google's Style guide
alias sortip='sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4' # Sort ip addresses
alias sudo='sudo ' # to allow sudoing with aliases
alias tmux="TERM=screen-256color TMUX_VERSION=$(tmux -V | cut -c 6-) TMUX_CONFDIR=\"${HOME}\" tmux"
alias tmhere='tmux new-session -A -s "$(basename $(pwd) | tr '.' '_')"' # protip: tmux doesn't like dots in session names
alias xo='xdg-open'

#
# Packaging
#
alias aptinst='apt-get install'
alias aptls='apt list --installed'
alias aptrm='apt-get remove'
alias apts='apt-cache search'
alias aptshow='apt-cache show'
alias aptsh='aptshow'
alias aptupd='apt-get update'
alias aptupg='apt-get upgrade'

#
# Aliases rather particular to my use-case
#
alias jdate="date '+%Y-%m-%d %H:%M:%S %z'"
alias locksleep='sudo echo && sudo -u csp i3lock -I 10 && sudo pm-suspend'
# unetbootin and sudo as per https://askubuntu.com/a/1006483/362696
alias unetbootin='xhost local:root && sudo QT_X11_NO_MITSHM=1 unetbootin'

#
# Functions
#
boxscale() {
  # Scale up a video up or down to the specified dimensions, maintaining
  # aspect ratio and letter/pillarboxing as necessary
  local infile=$1
  local dimensions=$2
  local outfile=$3

  ffmpeg -i "${infile}" -vf "scale=${dimensions}:force_original_aspect_ratio=decrease,pad=${dimensions}:(ow-iw)/2:(oh-ih)/2" "${outfile}"
}

# Ssh
dossh() {
  # Keep trying to connect over ssh
        ssh "$1"
        until [ $? -eq 0 ]; do
                sleep 1; ssh "$1"
        done
}

g() {
  # Google some input directly from cli
  # via Avinash Raj on AskUbuntu https://askubuntu.com/a/486021
  local search=""
  echo "Googling: $@"
  for term in $@; do
      search="$search%20$term"
  done
  xdg-open "https://www.google.com/search?q=$search"
}

hr() {
  # hr print horizontal rule, default with '-' but char can be provided
  # based on: https://www.reddit.com/r/commandline/comments/7zvmze/show_hr_a_cli_program_that_outputs_a_horizontal/durci2h/
  local outchar='-'
  if [ ! -z "${1}" ]; then
    if [ "${#1}" -eq 1 ]; then
      outchar="${1}"
    fi
  fi
  printf "%0.s${outchar}" $(seq 1 $(tput cols))
}

# http get content length from remote url
httplen() {
  curl -L --head "${1}" 2>/dev/null | tr '^M' '\n' | grep -P '^Content-Length:' | cut -d ' ' -f 2
}

# id3 add image to mp3 file with eyeD3
id3img() {
  local imgpath
  imgpath="${1}"
  local mp3file
  mp3file="${2}"

  eyeD3 --add-image "${imgpath}:FRONT_COVER" "${mp3file}"
}

# md5sum comparison
md5comp() {
  local md5sum
  local newsum
  md5sum=$(md5sum "$1" | tr -s ' ' | cut -d ' ' -f 1)
  for filename in "$@"; do
    newsum=$(md5sum "$filename" | tr -s ' ' | cut -d ' ' -f 1)
    if [ "$newsum" != "$md5sum" ]; then
      echo "No match"
      return 1
    fi
  done

  echo "Match"
  return 0
}

moshr() {
  # Open mosh to host $1 with a screen session as root
  mosh_screen $1 '' 'sudo'
}

moshs() {
  # Open mosh to host $1 with a screen session as same user
  mosh_screen $1
}


mosh_screen() {
  # Connect to mosh with a screen session.
  #
  # Params:
  #  $1: Hostname
  #  $2: Screen session name. If not given defaults to username
  #  $3: sudo? Sudos if nonempty

  if [ ! -z "$2" ]; then
    screenname=$2
  else
    screenname=$(whoami)
  fi
  if [ ! -z "$3" ]; then
    sudocmd='sudo '
  else
    sudocmd=' '
  fi
  hostnameshellcmd='$(hostname)'
  mosh "${1}" -- bash -c "echo \"Logging into host ${1}  identifying as ${hostnameshellcmd}\"; ${sudocmd} screen -DR -S ${screenname}"
}

# New password maker
newpass() {
  local len
  if [ -z "${1}" ]; then
    len=30
  else
    len="${1}"
  fi
  openssl rand -base64 "${len}" | tr -d '\n' | head -c "${len}"
  # Output a newline if westdout is a terminal
  if [ -t 1 ]; then
    echo
  fi
}



sshrs() {
  # Open ssh to host "${1}" with a screen session as root
  ssh_mux 'screen' "${1}" '' 'sudo'
}
sshs() {
  # Open ssh to host "${1}" with a screen session as same user
  ssh_mux 'screen' "${1}"
}
sshrt() {
  # Open ssh to host "${1}" with a tmux session as root
  ssh_mux 'tmux' "${1}" '' 'sudo'
}

ssht() {
  # Open ssh to host "${1}" with a tmux session as same user
  ssh_mux 'tmux' "${1}"
}

ssh_mux() {
  # Connect to ssh with a screen/tmux multiplexer session.
  #
  # Params:
  #  $1: [screen|tmux]
  #  $2: Hostname
  #  $3: Tmux session name. If not given defaults to username
  #  $4: sudo? Sudos if nonempty

  (! [ -z "${1}" ] && ! [ -z "${2}" ]) || return 1

  local session_name
  if [ ! -z "$3" ]; then
    session_name=$3
  else
    session_name=$(whoami)
  fi
  local sudocmd
  if [ ! -z "$4" ]; then
    sudocmd='sudo '
  else
    sudocmd=' '
  fi
  local hostnameshellcmd
  hostnameshellcmd='$(hostname)'

  if [ "${1}" == 'tmux' ]; then
    ssh -t ${2} "clear; echo \"Logging into host ${2}  identifying as ${hostnameshellcmd}\"; ${sudocmd} TMUX_VERSION=\$(tmux -V | cut -c 6-) TMUX_CONFDIR=\"${HOME}\" tmux -f  \"${HOME}/.tmux.conf\" attach-session -t ${session_name} || ${sudocmd} TMUX_VERSION=\$(tmux -V | cut -c 6-) TMUX_CONFDIR=\"${HOME}\" tmux -f \"${HOME}/.tmux.conf\" new-session -s ${session_name}"
  else
    ssh -t ${2} "clear; echo \"Logging into host ${2}  identifying as ${hostnameshellcmd}\"; ${sudocmd} screen -DRS ${session_name}"
  fi
}

tmux-chdir() {
  # Change PWD from within tmux session so new windows open there.
  # This depends upon the particular Tmux config in these dotfiles, including
  # an external script and custom aliases which set required environment
  # variables, in order to actually have any effect.

  local newdir

  newdir="${1}"

  if [ -z "${TMUX}" ]; then
    return 1
  fi
  if ! [ -d "${newdir}" ]; then
    return 1
  fi

  tmux set-environment PWD "${newdir}"
}

uconv() {
  # Convert units using GNU Units but remove the noise. Cut off the units.
  # Also filter out "to" from the arugments because units doesn't speak English
  # And my brain always seems to type it this way
  newargs=()
  for arg in "$@"; do
    if [ "${arg}" != 'to' ]; then
      newargs+=("${arg}")
    fi
  done
  units "${newargs[@]/#/}" | head -n 1 | tr -d ' \t' | cut -c 2-
}

uconvu() {
  # Convert units using GNU Units but remove the noise. LEave the units.
  # Also filter out "to" from the arugments because units doesn't speak English
  # And my brain always seems to type it this way
  newargs=()
  for arg in "$@"; do
    if [ "${arg}" != 'to' ]; then
      newargs+=("${arg}")
    fi
  done
  res=$(units "${newargs[@]/#/}" | head -n 1 | tr -d ' \t' | cut -c 2-)
  echo "${res}${newargs[-1]}"
}
