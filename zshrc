ZSH=$HOME/.oh-my-zsh
ZSH_THEME="neonlex"
DISABLE_AUTO_UPDATE="true"
DISABLE_LS_COLORS="true"

plugins=(brew bundler gem git neonlex rails3 rake rbenv ruby rvm vagrant)
if [[ $platform == "osx" ]]; then
  plugins+=(brew osx pow sublime)
elif [[ $platform == "linux" ]]; then
  plugins+=(debian command-not-found)
fi

export PATH="/usr/local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
