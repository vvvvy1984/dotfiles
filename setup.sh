if [[ -z $SHARED_PROFILE_HOME ]] ; then
    export SHARED_PROFILE_HOME=$(dirname $BASH_SOURCE)
fi

source $SHARED_PROFILE_HOME/bash/git-completion.bash
source $SHARED_PROFILE_HOME/bash/env
source $SHARED_PROFILE_HOME/bash/aliases
source $SHARED_PROFILE_HOME/bash/functions

source $SHARED_PROFILE_HOME/cljenv/bin/source
cljenv_autostart NOPS1
