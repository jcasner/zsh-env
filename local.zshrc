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

pull () {
  if [ -n "${1}" ]; then
    remote="${1}"
  else
    remote="upstream"
  fi
  if [ -n "${2}" ]; then
    branch="${2}"
  else
    branch="master"
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
    branch="master"
  fi
  `eval echo "git push ${remote} ${branch}"`
}

# ruby
RBENV_DIR="${HOME}/.rbenv"
if [ -d "${RBENV_DIR}" ]; then
  eval "$(rbenv init -)"
  export PATH="${HOME}/.rbenv/bin:${PATH}"
fi

# python
PYTHON_HOME="${HOME}/Library/Python/2.7"
export PATH="${PYTHON_HOME}/bin:${PATH}"
export PYTHONPATH="${PYTHON_HOME}/lib/python/site-packages"
if [ -d "${PYTHONPATH}/virtualenvwrapper" ]; then
  export WORKON_HOME="${HOME}/.virtualenvs"
  export PROJECT_HOME="${HOME}/Devel"
  source "${PYTHON_HOME}/bin/virtualenvwrapper.sh"
fi

# node
export NVM_DIR="${HOME}/.nvm"
if [ -d "${NVM_DIR}" ]; then
  . $(brew --prefix nvm)/nvm.sh
fi

# php
if [ -d /usr/local/etc/php/5.6 ]; then
  export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
fi

if [ -d /usr/local/etc/php/5.5 ]; then
  export PATH="$(brew --prefix homebrew/php/php55)/bin:$PATH"
fi

if [ -d /usr/local/etc/php/5.4 ]; then
  export PATH="$(brew --prefix homebrew/php/php54)/bin:$PATH"
fi
