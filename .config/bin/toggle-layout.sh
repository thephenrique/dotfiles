#!/bin/bash
if [ "$(cat /tmp/kb_layout 2>/dev/null)" = "intl" ]; then
  setxkbmap -layout us
  echo "us" >/tmp/kb_layout
else
  setxkbmap -layout us -variant intl
  echo "intl" >/tmp/kb_layout
fi
$xset_rate
