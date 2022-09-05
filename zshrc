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

unalias dr
unalias drm

export ARCHFLAGS="-arch x86_64"

export EDITOR="vim"

bindkey "[C" forward-word
bindkey "[D" backward-word

autoload -U compinit && compinit

filesToSource=( $(find ~/.zshd -type f | grep -v '\.git\|\.swp\|zshrc\|LICENSE\|README\|no_source') )

for file in "${filesToSource[@]}"; do
    echo "sourcing ${file}"
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


SSH_ENV=$HOME/.ssh/environment

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     echo succeeded
     chmod 600 ${SSH_ENV}
     . ${SSH_ENV} > /dev/null
     /usr/bin/ssh-add;
}

if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     ps -efp ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

function multi_line_prompt {
    export PROMPT=$'[%*] %{$fg[cyan]%}%n%{$reset_color%}:%{$fg[green]%}%c%{$reset_color%}$(git_prompt_info) \n%(!.#.$) '
}

function single_line_prompt {
    export PROMPT=$'[%*] %{$fg[cyan]%}%n%{$reset_color%}:%{$fg[green]%}%c%{$reset_color%}$(git_prompt_info) %(!.#.$) '
}

source <(template-service completion zsh)
source <(helmfile completion zsh)
source <(cilium completion zsh)
