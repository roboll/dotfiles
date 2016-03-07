#! /bin/bash

###############################################################################
# home.bash - home computer only
###############################################################################
if [ ! "$(cat "$HOME/.boxname" 2>&1)" == "scepter" ]; then
    return
fi

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add "$HOME/.ssh/$key" &>/dev/null
done;

export EDITOR=nvim
export GOPATH=~/dev

export PAGER="nvim -MR -c 'nnoremap q :q!<CR>' -"
function man() {
    nvim -c "let g:no_man_maps=1" -c "let g:man=1" -c "nnoremap q :qall!<CR>" -c "Man $@" -c "bdel 1"
}

function vnc() {
    open vnc://\$@
}

function cleandocker() {
    for i in $(docker ps -a -q); do docker rm -f $i; done;
    for i in $(docker images -q); do docker rmi -f $i; done;
}

function http() {
    local port="${1:-8000}"
    sleep 1 && open "http://localhost:${port}/" &
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

alias notes="vi ~/Dropbox/Notes"

function tmx() {
    [ -z "$TMUX" ] && {
        tmux -2 new-session -A -s "uber"
        builtin exit
    }
}

alias lock="light-locker-command -l"

# if in tmux, default behavior is kill-pane. if last pane, fall back to detach
function exit() {
    [ -z "$TMUX" ] || {
        if [[ "$(tmux list-panes | wc -l)" == "1" ]]; then
            tmux detach
        else
            tmux kill-pane
        fi
    }
}

[ -n "$TMUX" ] || tmx
