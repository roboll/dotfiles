#!/usr/bin/env bash

# ssh scp
function _ssh_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config ~/.ssh/config.d/* 2>/dev/null | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}

complete -F _ssh_completion ssh scp

function _notes_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(notes complete)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}

# notes
complete -F _notes_completion notes
#complete -o "default" -o "nospace" -W "$(notes complete)" notes
