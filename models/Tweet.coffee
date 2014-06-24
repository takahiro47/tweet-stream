colors = require 'colors'
mongoose = require 'mongoose'
Seq = require 'seq'
util = require 'util'

TweetModel = new mongoose.Schema
  created_at: type: Date # ツイート日時
  id: type: Number, unique: yes
  id_str: type: String
  text: type: String
  source: type: String
  truncated: type: Boolean
  in_reply_to_status_id: type: Number
  in_reply_to_status_id_str: type: String
  in_reply_to_user_id: type: Number
  in_reply_to_user_id_str: type: String
  in_reply_to_screen_name: type: String
  user: type: Object
  coordinates: type: Object
  contributors: type: Object
  retweet_count: type: Number
  favorite_count: type: Number
  entities: type: Object
  favorited: type: Boolean
  retweeted: type: Boolean
  filter_level: type: String
  lang: type: String
  data: type: Object
  registed_at: type: Date # データベース登録日時
  updated_at: type: Date # データベース更新日時
,
  versionKey: no

# ===================================
# Functions
# ===================================

# 便利関数

dump = (v) ->
  console.log util.inspect v

toDatetime = (date) ->
  datetime = (new Date date).toISOString().replace(/T/, ' ').replace /\..+/, ''

# ===================================
# Methods
# ===================================

TweetModel.statics.find_or_new = (data) ->
  M = @
  Seq()
    .seq_((next) ->
      M.findOne {id: data.id}, next
    )
    .seq_((next, tweet) ->
      unless tweet # ツイートがまだ存在しなかったならば
        tweet = new M data
        tweet.registed_at ?= Date.now()
        tweet.updated_at ?= Date.now()
        tweet.save()

        console.log ("@#{tweet.user.screen_name}".blue + " #{tweet.user.name}").bold + " #{tweet.text}"
      else
        console.log "this tweet is already exist.".bold.red
    )
    .catch((err) ->
      console.error err
    )

exports.Tweet = mongoose.model 'tweets', TweetModel

