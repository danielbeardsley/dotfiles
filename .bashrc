# .bashrc


source ~/.bash_ifixit

# allow <C-s> to pass through the terminal instead of stopping it
if [ -t 1 ]; then
   stty stop undef
fi

# Diff, using git's processing, format, and coloring, it rocks
alias diffg="git diff --no-index"
alias gl="git lg -30"
alias glg="git lg --all -30"
alias ll='ls -lh --color'
alias fs='feature switch'
# cause I never remember which uses -s and -t
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux ls'
# Always enable UTF8 support
alias tmux='tmux -u'

gfindf () { files="${1}"; find -P . -name "$files" -a ! -wholename '*/.*' ; }

# delete a local and a remote branch... only if it's been merged
git_delete_branch () {
   branch="${1}"
   git branch -d --merged master $branch && git push origin :$branch
}

eval `dircolors ~/.dircolors.ansi-dark`

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

####
# Bash Prompt
####
RED="\[\e[31m\]"
GRE="\[\e[32m\]"
YEL="\[\e[33m\]"
BLU="\[\e[34m\]"
PUR="\[\e[35m\]"
CYA="\[\e[36m\]"
WHI="\[\e[37m\]"
NUL="\[\e[0m\]"

# Show non-zero exit-code as a red "E:{code}"
EXIT="FOO=\$?; [ ! \$FOO = 0 ] && echo -ne \"${RED}E:\$FOO${NUL}\""

export PS1="${GRE}\u ${WHI}\t${YEL}\$(__git_ps1 \" (%s)\") ${PUR}\w${NUL} \`$EXIT\`\n▶  "
