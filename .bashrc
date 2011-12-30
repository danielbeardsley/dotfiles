# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export GFIND_EXCLUDE="3P:Deprecated"
export PS1="▊ \[\033[32m\]\u \[\033[37m\]\A \[\033[0;35m\]\w\[\033[0m\] ▶  "
export PS1="\[\033[7;34m\] \w \[\033[27m\]⚫\[\033[0m\] "

source ~/.bash_ifixit

# allow <C-s> to pass through the terminal instead of stopping it
stty stop undef

alias diffg="git diff --no-index"
alias ll='ls -l -G'

# User specific aliases and functions
alias c="ssh dbeardsley@cominor.com"

gfindf () { files="${1}"; find -P . -name "$files" -a ! -wholename '*/.*' ; }

git_delete_branch () {
   branch="${1}"
   git branch -d --merged master $branch && git push github :$branch
}

function git_prune_branches {
  current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ "$current_branch" != "master" ]; then
    echo "WARNING: You are on branch $current_branch, NOT master."
  fi
    echo "Fetching merged branches..."
  git remote prune github
  remote_branches=$(git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$")
  local_branches=$(git branch --merged | grep -v 'master$' | grep -v "$current_branch$")
  if [ -z "$remote_branches" ] && [ -z "$local_branches" ]; then
    echo "No existing branches have been merged into $current_branch."
  else
    echo "This will remove the following branches:"
    if [ -n "$remote_branches" ]; then
      echo "$remote_branches"
    fi
    if [ -n "$local_branches" ]; then
      echo "$local_branches"
    fi
    read -p "Continue? (y/n): " -n 1 choice
    echo
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      # Remove remote branches
      git push origin `git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$" | sed 's/github\//:/g' | tr -d '\n'`
      # Remove local branches
      git branch -d `git branch --merged | grep -v 'master$' | grep -v "$current_branch$" | sed 's/github\///g' | tr -d '\n'`
    else
      echo "No branches removed."
    fi
  fi
}
