#!/bin/bash
# error undef の設定
set -eu

# ロジック
echo "今から始めるくそwifi"
START=`date +%s`
END=`(date --date '2023/0508' +%s)`
restSeconds=$((END-START))

echo ${restSeconds}

# slack の書式設定
slackData () {
  restDays="$((${restSeconds} / (60 * 60 * 24)))"
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

TOKEN_GENE="nUF9Jp7JrWK30VvL0z6SggPy"

# 環境変数は crontab に書いている
# 通常の path では無理っぽい。直にコマンド打つのであればいける
# ci で直に url を書くと gitgurdian が差し止める。invalid になった後で sh で叩いても invalid
curl -X POST -H 'Content-type: application/json' --data "$(slackData)" https://hooks.slack.com/services/T02633YV1GW/B02R6HYP4LT/${TOKEN_GENE}



