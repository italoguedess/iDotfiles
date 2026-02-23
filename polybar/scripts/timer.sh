#!/bin/bash

FILE="/tmp/polybar_timer"

timer_hard_reset() {
  POMODORO="$(expr 50 \* 60)"
  echo "TIMER=$POMODORO" > $FILE
  echo "ACTIVE=0" >> $FILE
  echo "LAPS=0" >> $FILE
}

if [[ ! -f "$FILE" ]]; then
  timer_hard_reset
fi

timer_soft_reset() {
  source $FILE
  POMODORO="$(expr 50 \* 60)"
  echo "TIMER=$POMODORO" > $FILE
  echo "ACTIVE=0" >> $FILE

  if [[ $# -eq 0 ]]; then
    echo "LAPS=$LAPS" >> $FILE
  else
    echo "LAPS=$(expr $LAPS \+ 1)" >> $FILE
  fi
}

timer_count() {
  source $FILE
  MIN="$(expr $TIMER / 60)"
  SEC="$(expr $TIMER \- $MIN \* 60)"

  # printf "  $LAPS"

  if [[ $ACTIVE -eq 1 ]]; then
    printf " 󰔛 "
    TIMER="$(expr $TIMER \- 1)"
  else
    printf " 󱫟 "
  fi
  printf "%02d:%02d;%d" $MIN $SEC $LAPS

  if [[ $TIMER -eq 0 ]]; then
    timer_soft_reset count_lap
  else
    echo "TIMER=$TIMER" > $FILE
    echo "ACTIVE=$ACTIVE" >> $FILE
    echo "LAPS=$LAPS" >> $FILE
  fi

}

timer_toggle() {
  source $FILE
  if [[ $ACTIVE -eq 1 ]]; then
    ACTIVE=0
  else
    ACTIVE=1
  fi

  echo "TIMER=$TIMER" > $FILE
  echo "ACTIVE=$ACTIVE" >> $FILE
  echo "LAPS=$LAPS" >> $FILE
}


case "$1" in
    --toggle)
      timer_toggle
      ;;
    --soft-reset)
      timer_soft_reset
      ;;
    --hard-reset)
      timer_hard_reset
      ;;

    *)
      timer_count
      ;;
esac 
