c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

export EDITOR='vim'

# autocorrect is more annoying than helpful
unsetopt correct_all

# a few aliases I like
alias run-redis="redis-server /usr/local/etc/redis.conf"
alias run-couchdb="couchdb"
alias run-mongodb="mongod run --config /usr/local/etc/mongod.conf"
alias run-riak="riak start && riak attach"
porn() { ruby $1 -n /XXX/ }

# add plugin's bin directory to path
export PATH="$(dirname $0)/bin:$PATH"
