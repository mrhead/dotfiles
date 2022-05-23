export PATH="/opt/homebrew/bin:$PATH"

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

for function in ~/.zsh/functions/*; do
  source $function
done

# automatically enter directories without cd
setopt auto_cd

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.history

# share history between simultaneous shells
setopt SHARE_HISTORY

# do not store space ' ' prefixed commands in history
setopt HIST_IGNORE_SPACE

# Enable extended globbing
setopt EXTENDED_GLOB

# setup rbenv
eval "$(rbenv init -)"

# enable comments in command line
setopt interactivecomments

# do not catch ctrl+s
stty -ixon

# edit command in vim by hitting ESC+v
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# init memberful CLI
eval "$(~/code/memberful/cli/bin/memberful init -)"

# use brew's Homebrew's OpenSSL
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# hook https://direnv.net/
eval "$(direnv hook zsh)"
eval "$(rbenv init - zsh)"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
