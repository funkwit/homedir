#----------------------------------------------------------#
# Bash Options
#----------------------------------------------------------#
# set -o vi
# set -o ignoreeof

shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s extglob

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize




# Bash History Options

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Prevent common commands from being added to .bash_history
export HISTIGNORE="&:ls:jobs:[bf]g:exit:clear"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000



# Misc standard stuff

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"





# Color & Prompt stuff
COLOR_NONE="\[\033[0m\]"
COLOR_LIGHT_WHITE="\[\033[1;37m\]"
COLOR_WHITE="\[\033[0;37m\]"
COLOR_GRAY="\[\033[1;30m\]"
COLOR_BLACK="\[\033[0;30m\]"

COLOR_RED="\[\033[0;31m\]"
COLOR_LIGHT_RED="\[\033[1;31m\]"
COLOR_GREEN="\[\033[0;32m\]"
COLOR_LIGHT_GREEN="\[\033[1;32m\]"
COLOR_YELLOW="\[\033[0;33m\]"
COLOR_LIGHT_YELLOW="\[\033[1;33m\]"
COLOR_BLUE="\[\033[0;34m\]"
COLOR_LIGHT_BLUE="\[\033[1;34m\]"
COLOR_MAGENTA="\[\033[0;35m\]"
COLOR_LIGHT_MAGENTA="\[\033[1;35m\]"
COLOR_CYAN="\[\033[0;36m\]"
COLOR_LIGHT_CYAN="\[\033[1;36m\]"


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=full;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi


# Load custom functions
[[ -r ${HOME}/.bash/functions ]] && source ${HOME}/.bash/functions
if [ "$color_prompt" = yes ]; then
    user_color=$COLOR_GREEN
    dir_color=$COLOR_BLUE
    COLOR_OFF=$COLOR_NONE
    COLOR_SCM_BRANCH=$COLOR_RED
    COLOR_SCM_STATE=$COLOR_LIGHT_RED
elif [ "$color_prompt" = full ]; then
    user_color=`extColor 22`
    dir_color=`extColor 19`
    COLOR_SCM_BRANCH=`extColor 172`
    COLOR_SCM_STATE=`extColor 160`
    COLOR_OFF=$COLOR_NONE
fi

PROMPT="${debian_chroot:+($debian_chroot)}[${user_color}\u@\h${COLOR_OFF}]:${dir_color}\W${COLOR_OFF} \$(hg_in_repo)${COLOR_SCM_BRANCH}\$(hg_branch)${COLOR_OFF}${COLOR_SCM_STATE}\$(hg_status)${COLOR_OFF}\$(prompt_char)"

unset color_prompt force_color_prompt user_color dir_color 


PS2="moar!> "


export M2_HOME=/usr/local/maven
addToPath ${M2_HOME}/bin
