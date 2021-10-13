#!/usr/bin/env zsh

# setup confirmation prompt
function confirm {
  read -q "response?$1 [y/N]"
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    return 0
  else
    return 1
  fi
}

function browse {
  python3 -m webbrowser -t "$1"
}
