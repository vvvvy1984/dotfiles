function install_ssh_key() {
    cat ~/.ssh/id_rsa.pub | ssh $1 'cat - >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
}

function tfind {
    find . -name "*.$1"
}

function tgrep {
   egrep -R --include="*.$1" "$2" .
}

function tchecksum {
    find . -name "*.$1" -printf "%s-%C@" | md5sum | awk '{print $1;}'
}

function run_on_change {
    value=""
    ftype=$1
    command=$2
    args="$3"
    while [ -1 ]; do
          new_value=`tchecksum $ftype`
          if [[ $new_value != $value ]]; then
              command $command $args
          fi
          value=$new_value
    done
}

function sudo_str {
    sudo bash -c "$1"
}

function get_mac_address {
   ifconfig  | fgrep "Link" | egrep -v "lo|inet6"  | awk '{print $5;}'
}

function get_ip_address {
   ifconfig | grep "inet addr" | grep -v "127.0.0.1" | awk '{print $2;}' | cut -d : -f 2
}

function cdl {
  cd $1 && ls -l
}

function install_brew {
  curl -L http://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C /usr/local
}

function git_update_externals {
    update_this_remote() {
        echo $path && cd $path
        git checkout master
        git pull origin | grep 'Already up-to-date.'
        cd -
    }

    git submodule update --init
    git submodule foreach update_this_remote
}

function gpg_encrypt_file {
    password=${1?Usage: $0 <password> <file>}
    file=${2?Usage: $0 <password> <file>}

    echo $password | gpg --batch -q --passphrase-fd 0 --cipher-algo AES256 -c $file
}

function gpg_decrypt_file {
    password=${1?Usage: $0 <password> <file>}
    file=${2?Usage: $0 <password> <file>}

    output=`echo $file | sed 's/\.gpg//g'`

    echo $password | gpg --batch -q -o $output --passphrase-fd 0 --decrypt $file
}


function autocommit {
    interval=${1?Usage: autocommit <seconds>}
    while true; do
        git commit -am "Autocommit: `date`"
        sleep $interval
    done
}

function defaultjdk {
    local vmdir=/System/Library/Frameworks/JavaVM.framework/Versions
    local ver=${1?Usage: defaultjdk <version>}

    [ -z "$2" ] || error="Too many arguments"
    [ -d $vmdir/$ver ] || error="Unknown JDK version: $ver"
    [ "$(readlink $vmdir/CurrentJDK)" != "$ver" ] || error="JDK already set to $ver"


    if [ -n "$error" ]; then
    echo $error
    return 1
    fi

    echo -n "Setting default JDK & HotSpot to $ver ... "

    if [ "$(/usr/bin/id -u)" != "0" ]; then
    SUDO=sudo
    fi

    $SUDO /bin/rm /System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK
    $SUDO /bin/ln -s $ver /System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK
   
    echo Done.
}

function setjdk {
    local vmdir=/System/Library/Frameworks/JavaVM.framework/Versions
    local ver=${1?Usage: setjdk <version>}

    [ -d $vmdir/$ver ] || {
    echo Unknown JDK version: $ver
    return 1
    }

    echo -n "Setting this terminal's JDK to $ver ... "

    export JAVA_HOME=$vmdir/$ver/Home
    PATH=$(echo $PATH | tr ':' '\n' | grep -v $vmdir | tr '\n' ':')
    export PATH=$JAVA_HOME/bin:$PATH
   
    java -version
}

function _setjdk_completion (){
    COMPREPLY=()

    local vmdir=/System/Library/Frameworks/JavaVM.framework/Versions
    local cur=${COMP_WORDS[COMP_CWORD]//\\\\/}
    local options=$(cd $vmdir; ls | grep 1. | tr '\n' ' ')

    COMPREPLY=($(compgen -W "${options}" ${cur}))
}

complete -F _setjdk_completion -o filenames setjdk
complete -F _setjdk_completion -o filenames defaultjdk
