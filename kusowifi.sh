#!/bin/bash
# error undef の設定
set -eu

# ロジック
echo "今から始めるくそwifi"
thisYear=`date "+%Y"`
thisMonth=`date "+%m"`
thisDay=`date "+%d"`

xYear=2023
xMonth=5
xDay=8

restYear=$(((xYear - thisYear)*365));
restMonth=$(((xMonth - thisMonth)*30));
restDay=$((xDay - thisDay));
restDays=$((restYear+restMonth+restDay+25))
echo ${restDays}

# 関数の定義
say_hello () {
    echo "Hello, world!"
}
# 関数の呼び出し
say_hello

# slack の書式設定
slackData () {
  restDays=$((restYear+restMonth+restDay+25))
  cat <<EOF
{
    "blocks": [
        {
            "type": "section",
            "text": {
                "type": "mrkdwn",
                "text": "kusowifi 残り契約日数 ${restDays}日"
            }
         }
    ]
}
EOF
}

# 環境変数は crontab に書いている
# 通常の path では無理っぽい。直にコマンド打つのであればいける
# ci で直に url を書くと gitgurdian が差し止める。invalid になった後で sh で叩いても invalid
curl -X POST -H 'Content-type: application/json' --data "$(slackData)" $(hoge)


