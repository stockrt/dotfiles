source "$HOME/.git-completion.bash"
source "$HOME/.git-prompt.sh"
export PS1='\t \u@\h \w$(__git_ps1 " (%s)") \$ '
export GIT_PS1_DESCRIBE_STYLE="branch"
export GIT_PS1_SHOWCOLORHINTS="true"
export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWSTASHSTATE="true"
export GIT_PS1_SHOWUNTRACKEDFILES="true"
export GIT_PS1_SHOWUPSTREAM="auto verbose"
