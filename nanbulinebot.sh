#!/bin/bash
set -u
while true
do
    curl -s -S --location http://traininfo.jreast.co.jp/train_info/kanto.aspx | grep "<p class=\"mt10 sp_mt5 sp_mr25\">南武線" | sed -r -e "s|<[^>]+>||g" -e "s/&nbsp;//g" -e "s/[	 ^M]//g" > .nanbulinebot-now
    [ -f .nanbulinebot-last ] && diff .nanbulinebot-now .nanbulinebot-last > /dev/null || (cat .nanbulinebot-now && ~/nanbulinebot/tweet.sh post < .nanbulinebot-now)
    mv .nanbulinebot-now .nanbulinebot-last
    sleep 60
done
