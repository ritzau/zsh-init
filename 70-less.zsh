if [[ -f /usr/local/opt/source-highlight/bin/src-hilite-lesspipe.sh ]]
then
    export LESSOPEN="| /usr/local/opt/source-highlight/bin/src-hilite-lesspipe.sh %s"
    export LESS=' -R '

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
fi
