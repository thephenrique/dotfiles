#!/bin/bash

dump=/tmp/terminal.dump

rm -f $dump
tmux capture-pane -pS -4096 >$dump
tmux new-window -n "<TerminalDump>" "nvim '+ normal G' $dump"
