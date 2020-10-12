#
# ~/.bashrc
#

[[ $- != *i* ]] && return

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "[${RETVAL}]"
}
colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

shopt -s autocd # Auto cd when write a valid directory name.

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

case $HOSTNAME in
				"arch")						host=" "; os_color="34";;
				"manjaro")					host=" "; os_color="32";;
				"debian")					host=" "; os_color="31";;
				"ubuntu")					host=" "; os_color="31";;
				"fedora")					host=" "; os_color="34";;
				"linuxmint"|"mint")			host=" "; os_color="32";;
				"opensuse")					host=" "; os_color="32";;
				"elementary"|"elementaryos")host=" "; os_color="34";;
				"gentoo")					host=" "; os_color="35";;
				"slackware")				host=" "; os_color="30";;
				"redhat")					host=" "; os_color="31";;
				"centos")					host=" "; os_color="33";;
				"alpine")					host=" "; os_color="34";;
				"devuan")					host=" "; os_color="30";;
				"freebsd"|"bsd")			host=" "; os_color="31";;
				*) 							host="$HOSTNAME"; os_color="34";;
esac

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;${os_color}m\]\u\[\033[00m\] at \[\033[00;${os_color}m\]${host}\[\033[00m\]:\[\033[32m\]\w\[\e[31m\]$(nonzero_return)\[\033[00m\]\$\[\033[00m\] '
	fi


# color the man command
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# -- Exports
export PATH="$PATH:$HOME/.local/bin"
export QT_QPA_PLATFORMTHEME=gtk2
# export QT_SELECT=4

# --Aliases
# Aliases for some commands
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias lla='ls -lah --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias setwp='feh --bg-scale ~/Pictures/wallpapers/wallp1.png'
alias p='sudo pacman'
alias v='vim'
alias sv='sudo vim'

# Aliases for Autodock suite
alias pmv='/home/egemen/CADDWorks/MGLTools-1.5.7/bin/pmv'
alias adt='/home/egemen/CADDWorks/MGLTools-1.5.7/bin/adt'
alias vision='/home/egemen/CADDWorks/MGLTools-1.5.7/bin/vision'
alias pythonsh='/home/egemen/CADDWorks/MGLTools-1.5.7/bin/pythonsh'
alias raccoon='/home/egemen/CADDWorks/MGLTools-1.5.7/bin/raccoon'    
alias adfr='/home/egemen/CADDWorks/ADFRsuite-1.0/bin/adfr'
alias agfr='/home/egemen/CADDWorks/ADFRsuite-1.0/bin/agfr'
alias agfrgui='/home/egemen/CADDWorks/ADFRsuite-1.0/bin/agfrgui'
alias autosite='/home/egemen/CADDWorks/ADFRsuite-1.0/bin/autosite'
alias flipdock='pythonsh /home/egemen/CADDWorks/MGLTools-1.5.7/MGLToolsPckgs/AutoDockFR/bin/runadfr.py'
alias prepare_ligand='/home/egemen/CADDWorks/ADFRsuite-1.0/bin/prepare_ligand'
alias prepare_receptor='/home/egemen/CADDWorks/ADFRsuite-1.0/bin/prepare_receptor'
alias adcp='/home/egemen/CADDWorks/ADFRsuite-1.0/bin/adcp'

# Aliases for my git bare repos.
alias dotfiles='/usr/bin/git --git-dir=/home/egemen/.dotfiles/ --work-tree=/home/egemen'
alias trdocumentation='/usr/bin/git --git-dir=/home/egemen/Documents/.trdocumentation/ --work-tree=/home/egemen/Documents'
