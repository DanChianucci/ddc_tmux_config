#!/usr/bin/env bash

bar_color=black
active_bg_color=default
inactive_bg_color=default

hd1_color=blue
hd2_color=cyan
hd3_color=white

txt_color=black
theme_color=blue


# Status update interval
setup_basic_config(){
  # -- display -------------------------------------------------------------------
  tmux set -g base-index 1           # start windows numbering at 1
  tmux setw -g pane-base-index 1     # make pane numbering consistent with windows
  tmux setw -g automatic-rename on   # rename window to reflect current program
  tmux set -g renumber-windows on    # renumber windows when a window is closed
  tmux set -g set-titles on          # set terminal title
  tmux set -g display-panes-time 800 # slightly longer pane indicators display time
  tmux set -g display-time 1000      # slightly longer status messages display time
  tmux set -g status-interval 1      # redraw status every second


  # activity
  tmux set -g monitor-activity on
  tmux set -g visual-activity off
}


setup_colors(){
  # Basic status bar colors
  tmux set -g status-justify centre
  tmux set -g status-style "fg=$theme_color,bg=$bar_color"


  # Window status
  tmux set -g window-status-format " #I:#W#F "
  tmux set -g window-status-current-format " #I:#W#F "
  tmux set -g window-status-separator ""

  # Current window status
  tmux set -g window-status-current-style "fg=$theme_color,bg=$bar_color"

  # Window with activity status
  tmux set -g window-status-activity-style "fg=$theme_color, bg=$bar_color"

  #Window Styles
  tmux set -g window-style        "fg=default, bg=$inactive_bg_color"
  tmux set -g window-active-style "fg=default, bg=$active_bg_color"

  # Pane border
  tmux set -g pane-border-style "fg=$theme_color,bg=$active_bg_color"

  # Active pane border
  tmux set -g pane-active-border-style "fg=$theme_color,bg=$active_bg_color"

  # Pane number indicator
  tmux set -g display-panes-colour white
  tmux set -g display-panes-active-colour $theme_color

  # Clock mode
  tmux set -g clock-mode-colour $theme_color


  # Message
  tmux set -g message-style "fg=$txt_color,bg=$theme_color"

  # Command message
  tmux set -g message-command-style "fg=$txt_color,bg=$theme_color"

  # Mode
  tmux set -g mode-style "fg=$txt_color,bg=$theme_color"
}



setup_left_status(){
  # Left side of status bar
  tmux set -g status-left-style "fg=$txt_color,bg=$bar_color"
  tmux set -g status-left-length 150
  tmux set -g status-left "$(printf "%s" \
    "#[fg=$txt_color ,bg=$hd1_color] #S " \
    "#[fg=$hd1_color ,bg=$hd2_color]" \
    "#[fg=$txt_color ,bg=$hd2_color] #I:#P " \
    "#[fg=$hd2_color ,bg=$hd3_color]" \
    "#[fg=$txt_color ,bg=$hd3_color] #{?client_prefix,prefix,#{?pane_in_mode, copy ,normal}} " \
    "#[fg=$hd3_color ,bg=$bar_color]")"
}

setup_right_status(){
  # Right side of status bar
  tmux set -g status-right-style "fg=$txt_color,bg=$bar_color"
  tmux set -g status-right-length 150
  tmux set -g status-right "$(printf "%s" \
    "#[fg=$hd3_color ,bg=$bar_color]" \
    "#[fg=$txt_color ,bg=$hd3_color] %-I:%M:%S " \
    "#[fg=$hd2_color ,bg=$hd3_color]" \
    "#[fg=$txt_color ,bg=$hd2_color] %d-%b-%y " \
    "#[fg=$hd1_color ,bg=$hd2_color]" \
    "#[fg=$txt_color ,bg=$hd1_color] #h ")"
}



setup_title(){
  tmux setw -g set-titles-string "#{pane_current_path}"
}


main(){
  setup_basic_config
  setup_colors
  setup_left_status
  setup_right_status
  setup_title
}
main
