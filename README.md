tweet-stream
============

全世界のツイートをリアルタイムに保存してごにょごにょするスクリプト


## Quick start

First of all, DON’T PANIC. It will take 5 minutes to get the gist of what this script is all about.

### Installation

* You can install its dependencies with npm: `npm install`.
* Get Your Twitter API Tokens from [Twitter Application Manager](https://apps.twitter.com).
* Set your API tokens to 'config/env.json'.
* Then run, you can read all of the tweets from the world via twitter's Streaming API and save its tweets to mongoDB.

### Setup API

Edit config/env.json

```bash
{
  "mongo":                "mongodb://localhost/twitter",
  "consumer_key":         "COPY AND PASTE YOUR TOKEN!",
  "consumer_secret":      "COPY AND PASTE YOUR TOKEN!",
  "access_token_key":     "COPY AND PASTE YOUR TOKEN!",
  "access_token_secret":  "COPY AND PASTE YOUR TOKEN!"
}
```

## Usage

Hello world. (Read and save only then terminal opened.)

```bash
$ coffee ./app.coffee

# --- Connect successful ---
# @2Dbot 平面ロボ ちんぽ！ちんぽ！ちんぽ！ちんぽちんぽちんぽ！ちんぽイグゥゥゥ！！！！おちんぽイグゥゥゥゥウウゥウ！！！！！！ちんぽちんぽちんぽちんぽちんぽちんぽ！ちんぽ！
# @katapeee 異性から見る手紙の魅力を感じる部位ランク
# 【髪型】AAA
# 【顔】C
# 【腕】B
# 【手】A
# 【胸】F
# 【腰】C
# 【太腿】E
# 【膝】F
# 【足首】AA
# 以上の結果でした。
# #shindanmaker http://t.co/Ev1D5dJrbk
# 髪型そんなにいいんすか…
# @morizoooou がんばって育てたじょんそんが...
# ＿人人人人人＿
# ＞ 突然の留年 ＜
# ￣Y^Y^Y^Y^Y￣
# 主な原因: 不明
# 単位数：40　※全て選択B
# 最後の言葉 :『余裕』
# #生きろ大学生 http://t.co/e2a8dERMjT
# 余裕。
```

Run as a daemon.

```bash
$ pm2 start processes/production.json
```
