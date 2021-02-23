# zsh config
export ZSH=${HOME}/.oh-my-zsh
ZSH_THEME="clean"
plugins=(git)

source "${ZSH}/oh-my-zsh.sh"
export PATH="/usr/local/sbin:${PATH}"

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
export NVM_DIR="${HOME}/.nvm"
if [ -d "${NVM_DIR}" ]; then
  . $(brew --prefix nvm)/nvm.sh
fi

# android
export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"

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
