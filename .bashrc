# .bashrc


source ~/.bash_ifixit

# allow <C-s> to pass through the terminal instead of stopping it
stty stop undef

# Diff, using git's processing, format, and coloring, it rocks
alias diffg="git diff --no-index"
alias ruby="~/bin/ruby"
alias gem="~/bin/gem"
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

export PS1="▊ \[\033[32m\]\u \[\033[37m\]\A \[\033[0;35m\]\w\[\033[0m\] ▶  "
