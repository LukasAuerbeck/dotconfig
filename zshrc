export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="geoffgarside"

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(
  docker
  kubectl
  zsh-completions
)

source "$ZSH/oh-my-zsh.sh"

export ARCHFLAGS="-arch x86_64"

export EDITOR="vim"

bindkey "[C" forward-word
bindkey "[D" backward-word

autoload -U compinit && compinit

filesToSource=( $(find ~/.zshd -type f | grep -v '.git\|.swp\|zshrc\|LICENSE\|README\|no_source') )

for file in "${filesToSource[@]}"; do
    source "${file}"
    local aliasName="$(echo "$(basename "${file}")")"
    alias "${aliasName}=vim $file"
done

if [ -d /usr/local/bin/google-cloud-sdk ]; then
    source /usr/local/bin/google-cloud-sdk/completion.zsh.inc
    source /usr/local/bin/google-cloud-sdk/path.zsh.inc
fi

# Source vte when using ubuntu and tilix
if [ "${TILIX_ID}" ] || [ "${VTE_VERSION}" ]; then
    source /etc/profile.d/vte.sh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f "$HOME/.zshaliases" ]; then
    source "$HOME/.zshaliases"
fi

if [ -f "$HOME/.zshenv" ]; then
    source "$HOME/.zshenv"
fi
