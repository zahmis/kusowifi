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

# slack の書式設定
slackData()
{
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

# echo ${HOGE}


# 環境変数は crontab に書いている
# 通常の path では無理っぽい。直にコマンド打つのであればいける
curl -i -H "Content-type: application/json" -s -S -X POST -d "$(slackData)" "https://hooks.slack.com/services/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"

