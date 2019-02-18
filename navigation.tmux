#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="${CURRENT_DIR}/scripts"

setup_pane_nav(){
  # | - split panes
  tmux unbind '"'
  tmux unbind '%'
  tmux bind '-' split-window -v   # split current window horizontally
  tmux bind '|' split-window -h   # split current window vertically


  #Alt-arrow : Switch Panes
  tmux bind -n 'M-Left'  select-pane -L
  tmux bind -n 'M-Right' select-pane -R
  tmux bind -n 'M-Up'    select-pane -U
  tmux bind -n 'M-Down'  select-pane -D

  # pane Swapping
  tmux bind '>' swap-pane -D       # swap current pane with the next one
  tmux bind '<' swap-pane -U       # swap current pane with the previous one

  # pane resizing
  tmux bind -r 'H' resize-pane -L 2
  tmux bind -r 'J' resize-pane -D 2
  tmux bind -r 'K' resize-pane -U 2
  tmux bind -r 'L' resize-pane -R 2

  # maximize current pane
  tmux bind '+' run-shell -b "$SCRIPTS_DIR/maximize_pane"
}

setup_window_nav(){
  # Ctrl-arrow : Switch windows
  tmux unbind 'n'
  tmux unbind 'p'
  tmux bind -n 'C-Left'  previous-window
  tmux bind -n 'C-Right' next-window
  tmux bind 'Tab' last-window        # move to last active window
}

setup_session_nav(){
  #Shift-arrow : Switch sessions
  tmux bind -n S-Left  switch -p
  tmux bind -n S-Right switch -n
}

setup_mouse_bindings(){
  tmux bind 'm' run-shell -b "$SCRIPTS_DIR/toggle_mouse"
  tmux set -g mouse on
}


main(){
  setup_pane_nav
  setup_window_nav
  setup_session_nav
  setup_mouse_bindings
}
main
