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

if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Source vte when using ubuntu and tilix
if [ "${TILIX_ID}" ] || [ "${VTE_VERSION}" ]; then
    source /etc/profile.d/vte.sh
fi

export NVM_DIR="$HOME/.nvm"
if [ "$(uname -s)" = Darwin ]; then
    NVM_INSTALL_DIR="$(brew --prefix nvm)"
    [ -s "${NVM_INSTALL_DIR}/nvm.sh" ] && \. "${NVM_INSTALL_DIR}/nvm.sh" --no-use
else
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

wi() {
    q="${1}"
    awk -v RS= "/${q}/" ~/.ssh/config
}

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
if [ -f "$HOME/.zshaliases" ]; then
    source "$HOME/.zshaliases"
fi

if [ -f "$HOME/.zshenv" ]; then
    source "$HOME/.zshenv"
fi

if ! [ -z "${MASTER_PROJECT_DIR}" ]; then
    alias buildMasterThesis="${MASTER_PROJECT_DIR}/bin/latex-builder zsh -c "source /home/dev_user/.zshrc && /home/dev_user/mse-master-project/docs/master-thesis/bin/build.sh""
fi

