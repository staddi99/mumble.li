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


### Start needed mpd instances for botmaster ###
mpd $HOME/mpd"$bid"/mpd.conf


source ~/.rvm/scripts/rvm
rvm use @bots

### We need to be in this directory in order to start the bot(s).
cd $HOME/src/mumble-ruby-pluginbot/

### Export enviroment variable for tmux
export HOME=$HOME

### Start Mumble-Ruby-Bots - MPD instances must already be running. ###
# Bot
tmux new-session -d -s bot"$bid" "LD_LIBRARY_PATH=$HOME/src/celt/lib/ ruby $HOME/src/mumble-ruby-pluginbot/pluginbot.rb --config=$HOME/src/bot""$bid""_conf.rb$DEBUG"


### Optional: Clear playlist, add music and play it; three lines for every bot ###
# Bot
mpc -p 770"$bid" clear
mpc -p 770"$bid" add http://streams.radio-gfm.net/rockpop.ogg.m3u
mpc -p 770"$bid" play
