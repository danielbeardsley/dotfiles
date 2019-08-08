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
alias gl="git ls-files"
alias paths='echo "$PATH" | sed "s/:/\n/g"'

alias gc="git commit -v"
alias b="git unmerged | head"

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

export PS1="${GRE}\u ${WHI}\t${YEL}\$(__git_ps1 \" (%s)\") ${PUR}\w${NUL} \`$EXIT\`\n${NUL}▶  "

export PAGER="less -r"

FZF_GIT_FIND_CMD='rg --files . 2>/dev/null'
FZF_FIND_CMD='find . \( -name \.git -o  -name node_modules -o -name vendor \) -prune -o -type f -print 2>/dev/null | sed "s#^./##"'
export FZF_DEFAULT_COMMAND="$FZF_GIT_FIND_CMD || $FZF_FIND_CMD"

# Graphical log of ping times to a host
function pinglog() {
   domain="$1"
   ping "$domain" |
   awk 'BEGIN { FS="=" } {
   printf "%-13s", $4;
   size=log(50+$4)/log(1.04)-log(50)/log(1.04);
   for(c=0;c<size;c++)
      printf "=";
   printf "\n";
   fflush()
   }'
}
