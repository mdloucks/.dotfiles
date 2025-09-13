export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode disabled  # disable automatic updates
DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

bindkey '^J' autosuggest-execute


if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

#WHISKER SPECIFIC
alias whisker="cd /Users/mloucks/development/whisker-mobile/; bash ./scripts/dev/run.sh"
alias build_runner="flutter pub run build_runner build --delete-conflicting-outputs"
alias flutter="fvm flutter"
alias dart="fvm dart"

alias n="nvim"
alias prog="cd ~/Programming/"
alias hs="n ~/.hammerspoon/init.lua"
alias conf="nvim ~/.zshrc && source ~/.zshrc"
alias dotfiles="cd ~/.dotfiles/"
alias prog2="cd /Volumes/Acasis-1TB/Programming/"
alias br="flutter pub run build_runner build --delete-conflicting-outputs"


alias send="cd ~/Programming/sendspace/"
alias nvimconf="cd ~/.dotfiles/.config/nvim/"

# whisker-stuff
alias wh="cd ~/development/whisker-mobile/"

alias lg="lazygit"

# alias conf="nvim ~/.zshrc && source ~/.zshrc"
alias al="nvim ~/shell/alias.sh"

alias src="source ~/.zshrc"
alias v="nvim"
alias python="python3"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/mloucks/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# export NVM_DIR="$HOME/.nvm"
# [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
# [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/mloucks/.dart-cli-completion/zsh-config.zsh ]] && . /Users/mloucks/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

export JAVA_HOME=$(/usr/libexec/java_home -v 17)

export PATH="$PATH":"$HOME/fvm/default/bin"
