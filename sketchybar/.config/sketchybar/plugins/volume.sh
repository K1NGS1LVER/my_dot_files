#!/bin/sh

if [ "$SENDER" = "volume_change" ]; then
  VOLUME=$INFO

  case $VOLUME in
    0) ICON="􀊢"
    ;;
    *) ICON="􀊠"
  esac

  sketchybar --set $NAME icon="$ICON" label="$VOLUME%"
fi
