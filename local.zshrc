# zsh config
export ZSH=~/.oh-my-zsh
ZSH_THEME="clean"
plugins=(git)

# commands
alias git=hub

# ruby
RBENV_DIR="~/.rvm"
if [ -d `eval echo "${RBENV_DIR}"` ]; then
  echo "Configuring ruby"
  eval "$(rbenv init -)"
  export PATH="${HOME}/.rbenv/bin:${PATH}"
fi

# python
PYTHON_HOME="~/Library/Python/2.7"
export PATH="`eval echo ${PYTHON_HOME}/bin/:${PATH}`"
export PYTHONPATH="${PYTHON_HOME}/lib/python/site-packages"
if [ -d "`eval echo ${PYTHONPATH}/virtualenvwrapper`" ]; then
  export WORKON_HOME="${HOME}/.virtualenvs"
  export PROJECT_HOME="${HOME}/Devel"
  source "`eval echo ${PYTHON_HOME}/bin/virtualenvwrapper.sh`"
fi

# node
export NVM_DIR=~/.nvm
if [ -d "`eval echo ${NVM_DIR}`" ]; then
  . $(brew --prefix nvm)/nvm.sh
fi

source "${ZSH}/oh-my-zsh.sh"
