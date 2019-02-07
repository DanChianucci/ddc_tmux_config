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
  tmux set -g status-interval 1
}


setup_colors(){
  # Basic status bar colors
  tmux set -g status-justify centre
  tmux set -g status-fg $theme_color
  tmux set -g status-bg $bar_color


  # Window status
  tmux set -g window-status-format " #I:#W#F "
  tmux set -g window-status-current-format " #I:#W#F "
  tmux set -g window-status-separator ""

  # Current window status
  tmux set -g window-status-current-bg $theme_color
  tmux set -g window-status-current-fg $bar_color

  # Window with activity status
  tmux set -g window-status-activity-bg $theme_color
  tmux set -g window-status-activity-fg $bar_color

  #Window Styles
  # tmux set -g window-style        "fg=default, bg=$inactive_bg_color"
  # tmux set -g window-active-style "fg=default, bg=$active_bg_color"

  # Pane border
  tmux set -g pane-border-fg $theme_color
  tmux set -g pane-border-bg $active_bg_color

  # Active pane border
  tmux set -g pane-active-border-fg $theme_color
  tmux set -g pane-active-border-bg $active_bg_color

  # Pane number indicator
  tmux set -g display-panes-colour white
  tmux set -g display-panes-active-colour $theme_color

  # Clock mode
  tmux set -g clock-mode-colour $theme_color


  # Message
  tmux set -g message-fg $txt_color
  tmux set -g message-bg $theme_color

  # Command message
  tmux set -g message-command-fg $txt_color
  tmux set -g message-command-bg $theme_color

  # Mode
  tmux set -g mode-fg $txt_color
  tmux set -g mode-bg $theme_color
}



setup_left_status(){
  # Left side of status bar
  tmux set -g status-left-fg $txt_color
  tmux set -g status-left-bg $bar_color
  tmux set -g status-left-length 40
  tmux set -g status-left \
"#[fg=$txt_color ,bg=$hd1_color] #S "\
"#[fg=$hd1_color ,bg=$hd2_color]"\
"#[fg=$txt_color ,bg=$hd2_color] #(whoami) "\
"#[fg=$hd2_color ,bg=$hd3_color]"\
"#[fg=$txt_color ,bg=$hd3_color] #I:#P "\
"#[fg=$hd3_color ,bg=$bar_color]"
}

setup_right_status(){
  # Right side of status bar
  tmux set -g status-right-fg $txt_color
  tmux set -g status-right-bg $bar_color
  tmux set -g status-right-length 150
  tmux set -g status-right \
"#[fg=$hd3_color ,bg=$bar_color]"\
"#[fg=$txt_color ,bg=$hd3_color] %-I:%M:%S "\
"#[fg=$hd2_color ,bg=$hd3_color]"\
"#[fg=$txt_color ,bg=$hd2_color] %d-%b-%y "\
"#[fg=$hd1_color ,bg=$hd2_color]"\
"#[fg=$txt_color ,bg=$hd1_color] #h "
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
