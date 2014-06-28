# ===================================
# Dependency
# ===================================

Seq = require 'seq'
util = require 'util'
fs = require 'fs'
path = require 'path'

colors = require 'colors'
mongoose = require 'mongoose'
twitter = require 'ntwitter'
{Tweet} = require './models/Tweet'


# ===================================
# Configs
# ===================================

for k, v of require path.resolve 'config', 'env'
  process.env[k.toUpperCase()] = v

# ===================================
# Database
# ===================================

mongoose.connect process.env.MONGO


# ===================================
# Functions
# ===================================

# 便利関数

dump = (v) ->
  console.log util.inspect v


# オブジェクト配列を受け取り, Mongoose用スキーマに変換

typeMap =
  number: Number
  string: String
  boolean: Boolean
  object: Object
  function: Function

makeSchema = (data) ->
  schema = {}
  for x in data
    type = typeof data[x]
    if data[x] is null
      schema[x] = Object
    else if type is 'object'
      schema[x] = makeSchema data[x]
    else
      schema[x] = typeMap[type]
  schema


# ===================================
# Application
# ===================================

app = module.exports = ( ->

  stream = ->

    # Twitter's API Keys

    twit = new twitter
      consumer_key:         process.env.CONSUMER_KEY
      consumer_secret:      process.env.CONSUMER_SECRET
      access_token_key:     process.env.ACCESS_TOKEN_KEY
      access_token_secret:  process.env.ACCESS_TOKEN_SECRET

    twit.verifyCredentials (err, data) ->
      if not err
        console.info "--- Connect successful ---".bold.green

        # 検索キーワード

        locs    = '122.87,24.84,153.01,46.80'   # in Japan's territorial waters
        locs    = '-180.00,-90.00,180.00,90.00' # all over the world
        tracks  = 'バルス'                      # any search words

        # ストリームの読み込みと保存

        twit.stream 'statuses/filter',
          # 'track': tracks
          'locations': locs
        , (stream) ->
          stream.on 'data', (data) ->
            Tweet.find_or_new data

          stream.on 'end', (response) ->
            dump response

          stream.on 'destroy', (response) ->
            dump response

      else
        console.error "*** Connction error ***".bold.red
        console.error err.red

  stream()

  return app
)()
