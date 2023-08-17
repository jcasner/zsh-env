# zsh config
export ZSH=${HOME}/.oh-my-zsh
ZSH_THEME="clean"
plugins=(git)

source "${ZSH}/oh-my-zsh.sh"
export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:${PATH}"

# VS Code
VS_LIBRARY="${HOME}/Library/Application Support/Code/User/"
if [ -d "${VS_LIBRARY}" ]; then
  if [[ -f "${VS_LIBRARY}/settings.json" && ! -L "${VS_LIBRARY}/settings.json" ]]; then
    rm -f "${VS_LIBRARY}/settings.json"
  fi
  if [ ! -L "${VS_LIBRARY}/settings.json" ]; then
    ln -s "${HOME}/Code/zsh-env/settings.json" "${VS_LIBRARY}"
  fi
fi

# commands
alias git=hub
alias python=python3

prune () {
  git fetch --all && git fetch upstream --prune
  git branch --merged | grep -v '*' | awk '{print $1}' | xargs git branch -d
}

pull () {
  if [ -n "${1}" ]; then
    remote="${1}"
  else
    remote="upstream"
  fi
  if [ -n "${2}" ]; then
    branch="${2}"
  else
    branch=`git rev-parse --abbrev-ref HEAD`
  fi
  `eval echo "git pull ${remote} ${branch}"`
}

push () {
  if [ -n "${1}" ]; then
    remote="${1}"
  else
    remote="origin"
  fi
  if [ -n "${2}" ]; then
    branch="${2}"
  else
    branch=`git rev-parse --abbrev-ref HEAD`
  fi
  `eval echo "git push ${remote} ${branch}"`
}

# node
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# from https://github.com/nvm-sh/nvm#zsh
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# android
export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# MySQL 5.7
export PATH="/usr/local/opt/mysql@5.7/bin:${PATH}"

# ping until connection made
ssping () {
while :
do
    nc -z -w 3 $1 22 && break
    echo -n .
    sleep 1
done
}

alias ls="exa --icons"
alias cat=bat
