# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2
_ = require 'lodash'
log = (x...) -> console.log x...

url = require 'url'
needle = require 'needle'

_.type = (obj) ->
  if obj is 'undefined' or obj is null then return no
  Object::toString.call(obj).slice(8,-1).toLowerCase()

module.exports = extract = (url,opt,cb) ->
  if !cb and _.type(opt) is 'function'
    cb = opt
    opt = {}

  history = []

  req_opt = {
    read_timeout: 15000
    headers: {
      'User-Agent': opt.agent ? 'extract-redirects/robot'
    }
  }

  while 1
    history.push url

    await needle.get url, req_opt, defer e,r
    if e then return cb e

    if r.headers.location
      url = r.headers.location
    else
      break

  if opt.hosts_only
    history = _.uniq _.compact _.map history, (item) ->
      try
        parsed = require('url').parse(item)

        parts = [
          parsed.protocol
          '//'
          parsed.host ? parsed.hostname ? null
        ]

        if null in parts then return null
        return parts.join ''
      catch
        null

  cb null, history

if process.env.TAKY_DEV

  await extract 'http://google.com', defer e,links
  log /links/
  log links

  await extract 'http://google.com', {hosts_only:yes}, defer e,hosts
  log /hosts/
  log hosts

  ###
  /links/
  [ 'http://x.com/v1/public/click/81dayvknb489',
    'http://affiliate.x.com/rd/r.php?sid=1823&pub=220662&c1=&c2=&c3=',
    'https://www.x.com/special/?affid=gos&saffid=220662' ]
  /hosts/
  [ 'http://x.com',
    'http://affiliate.x.com',
    'https://www.x.com' ]
  ###

  process.exit 0

