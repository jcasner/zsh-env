# zsh config
export ZSH=~/.oh-my-zsh
ZSH_THEME="clean"
plugins=(git)

# commands
alias git=hub

# ruby
RVM_DIR="~/.rvm"
RUBY_VER="ruby-2.2.3"
if [ -d "${RVM_DIR}" ]; then
  export PATH="${PATH}:${RVM_DIR}/gems/${RUBY_VER}/bin:${RVM_DIR}/gems/${RUBY_VER}@global/bin:${RVM_DIR}/rubies/${RUBY_VER}/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${RVM_DIR}/bin"
  source "${RVM_DIR}/scripts/rvm"
fi

# python
export PATH="~/Library/Python/2.7/bin/:${PATH}"

# node
export NVM_DIR=~/.nvm
if [ -d "${NVM_DIR}" ]; then
  . $(brew --prefix nvm)/nvm.sh
fi

source "${ZSH}/oh-my-zsh.sh"
