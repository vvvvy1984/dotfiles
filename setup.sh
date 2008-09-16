if [[ -z $SHARED_PROFILE_HOME ]] ; then
    export SHARED_PROFILE_HOME=~/checkouts/shared-profile
fi

source $SHARED_PROFILE_HOME/bash/env
source $SHARED_PROFILE_HOME/bash/aliases
source $SHARED_PROFILE_HOME/bash/functions
