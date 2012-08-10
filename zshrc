ZSH=$HOME/.oh-my-zsh
ZSH_THEME="neonlex"
DISABLE_AUTO_UPDATE="true"
DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='osx'
fi

plugins=(bundler gem git neonlex rails3 rake rbenv ruby)
if [[ $platform == "osx" ]]; then
  plugins+=(brew osx pow sublime textmate vagrant)
elif [[ $platform == "linux" ]]; then
  plugins+=(debian command-not-found)
fi

export PATH="/usr/local/bin:$PATH"
export LANG="en_US.UTF-8"

source $ZSH/oh-my-zsh.sh

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# start tmux session on ssh connect
if [ "$PS1" != "" -a "${STARTED_TMUX:-x}" = x -a "${SSH_TTY:-x}" != x ]
then
  STARTED_TMUX=1; export STARTED_TMUX
  sleep 1
  ( (tmux has-session -t remote && tmux attach-session -t remote) || (tmux new-session -s remote) ) && exit 0
  echo "tmux failed to start"
fi
