if [[ -z $SHARED_PROFILE_HOME ]] ; then
    export SHARED_PROFILE_HOME=~/checkouts/shared-profile
fi

source $SHARED_PROFILE_HOME/bash/git-completion.bash
source $SHARED_PROFILE_HOME/bash/env
source $SHARED_PROFILE_HOME/bash/aliases
source $SHARED_PROFILE_HOME/bash/functions

export GITEXT_HOME=$SHARED_PROFILE_HOME/gitext
source $GITEXT_HOME/activate.sh
