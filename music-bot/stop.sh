#!/bin/bash

if [ "$1" != '' ];
then
    bid="$1"
fi


# Do an update of youtube-dl on every start as there are very often updates.
if [ -f $HOME/src/youtube-dl ]; then
    echo "Updating youtube-dl..."
    $HOME/src/youtube-dl -U
fi


### Kill running mumble-ruby-pluginbot ###
echo "Killing running bot$bid"
tmux kill-session -t bot"$bid" > /dev/null 2>&1
sleep 2
tmux kill-session -t bot"$bid" > /dev/null 2>&1


### Kill running mpd ###
echo "Killing running mpd instances of bot$bid"
mpd --kill $HOME/mpd"$bid"/mpd.conf > /dev/null 2>&1
sleep 2
mpd --kill $HOME/mpd"$bid"/mpd.conf > /dev/null 2>&1
