#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="${CURRENT_DIR}/scripts"


setup_config(){
  # -- general -------------------------------------------------------------------
  tmux set -g default-terminal "screen-256color" # colors!
  tmux setw -g xterm-keys on
  tmux set -s escape-time 10                     # faster command sequences
  tmux set -sg repeat-time 600                   # increase repeat timeout
  tmux set -s focus-events on
  tmux set -q -g status-utf8 on                  # expect UTF-8 (tmux < 2.2)
  tmux setw -q -g utf8 on
  tmux set -g history-limit 5000                 # boost history

  # -- display -------------------------------------------------------------------
  tmux set -g base-index 1           # start windows numbering at 1
  tmux setw -g pane-base-index 1     # make pane numbering consistent with windows
  tmux setw -g automatic-rename on   # rename window to reflect current program
  tmux set -g renumber-windows on    # renumber windows when a window is closed
  tmux set -g set-titles on          # set terminal title
  tmux set -g display-panes-time 800 # slightly longer pane indicators display time
  tmux set -g display-time 1000      # slightly longer status messages display time
  tmux set -g status-interval 10     # redraw status line every 10 seconds

  # activity
  tmux set -g monitor-activity on
  tmux set -g visual-activity off

  # GNU-Screen compatible prefix
  tmux set -g prefix2 C-a
  tmux bind C-a send-prefix -2

  tmux bind-key r run-shell 'tmux source-file ~/.tmux.conf; tmux display-message "Sourced .tmux.conf!"'

  # create session
  tmux bind C-c new-session
  tmux bind C-f command-prompt -p find-session 'switch-client -t %%'
}

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

setup_copy_mode(){
  tmux bind 'Enter' copy-mode # enter copy mode
  tmux bind -T copy-mode-vi 'v' send -X begin-selection
  tmux bind -T copy-mode-vi 'C-v' send -X rectangle-toggle
  tmux bind -T copy-mode-vi 'y' send -X copy-selection-and-cancel
  tmux bind -T copy-mode-vi 'Escape' send -X cancel
  tmux bind -T copy-mode-vi 'H' send -X start-of-line
  tmux bind -T copy-mode-vi 'L' send -X end-of-line
}

setup_mouse_bindings(){
  tmux bind 'm' run-shell -b "$SCRIPTS_DIR/toggle_mouse"
  tmux set -g mouse on
}


main(){
  setup_config
  setup_pane_nav
  setup_window_nav
  setup_session_nav
  setup_copy_mode
  setup_mouse_bindings
}
main
