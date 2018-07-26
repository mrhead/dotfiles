# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

prompt() {
  if [ $? != 0 ]; then
    LAST_COMMAND_STATUS="%{$fg_bold[red]%}!%{$reset_color%}"
  else
    LAST_COMMAND_STATUS=''
  fi

  echo "$(git_prompt_info)[%{$fg_bold[blue]%}%~%{$reset_color%}]$LAST_COMMAND_STATUS "
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='$(prompt)'

# load thoughtbot/dotfiles scripts
export PATH="$HOME/.bin:$PATH"

# load Memberful CLI
export PATH=$PATH:/Users/head/ruby/memberful/cli/bin
