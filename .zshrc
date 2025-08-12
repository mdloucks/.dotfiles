#
#
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.


 # plugins=(
 #  zsh-autosuggestions
 #  zsh-syntax-highlighting
 # )

source $ZSH/oh-my-zsh.sh



ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

bindkey '^J' autosuggest-execute


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#


#WHISKER SPECIFIC
alias whisker="cd /Users/mloucks/development/whisker-mobile/; bash ./scripts/dev/run.sh"
export PATH=$HOME/development/flutter/bin:$PATH
alias build_runner="flutter pub run build_runner build --delete-conflicting-outputs"


alias scripts="cd ~/Scripts/"
alias fs="cd ~/Scripts/fs-manager/"

alias ma="bash ~/Scripts/sshfs/mount-all.sh"
alias kittycarts="~/Scripts/fs-manager/unmount/kittycarts.online & ~/Scripts/fs-manager/mount/kittycarts.online && cd ~/filesystems/kittycarts.online && nvim"
alias dash="~/Scripts/fs-manager/unmount/dash.magnusbox.com &  ~/Scripts/fs-manager/mount/dash.magnusbox.com && cd ~/filesystems/dash.magnusbox.com/ && nvim"
alias nvimconf="cd ~/.dotfiles/.config/nvim/"
alias host="cd ~/Programming/kittycarts.online/pb_public/host/"
alias player="cd ~/Programming/kittycarts.online/pb_public/player/"
alias n="nvim"
alias prog="cd ~/Programming/"
alias hs="n ~/.hammerspoon/init.lua"
alias mentor="cd /Users/mloucks/Programming/SVSU/CS471/mentorship-program"
alias conf="nvim ~/.zshrc && source ~/.zshrc"
alias svsu="cd ~/Programming/SVSU/"
alias dotfiles="cd ~/.dotfiles/"
alias prog2="cd /Volumes/Acasis-1TB/Programming/"
alias br="flutter pub run build_runner build --delete-conflicting-outputs"

# whisker-stuff
alias wh="cd ~/development/whisker-mobile/"

# ssh
alias prodssh="ssh Matt@dash.magnusbox.com"
alias devssh="ssh Matt@devdash.magnusbox.com"
alias kittyssh="ssh root@kittycarts.online"
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

git config --global ~/.dotfiles/gitalias.txt
