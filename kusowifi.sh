set -eu

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

echo ${thisYear}
echo $restYear
echo $restMonth
echo $restDay
restDays=$((restYear+restMonth+restDay+25))
echo ${restDays}
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


curl -i -H "Content-type: application/json" -s -S -X POST -d "$(slackData)" "${SLACK_WEBHOOK_URL}"
