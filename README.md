# extract-redirects

# install

using [npm](https://npmjs.org)

```
npm i extract-redirects --save
```

# example

``` coffeescript
log = console.log
extract = require 'extract-redirects'

await extract 'http://x.com/v1/public/click/81dayvknb489', defer e,links
log /links/
log links

await extract 'http://x.com/v1/public/click/81dayvknb489', {hosts_only:yes}, defer e,hosts
log /hosts/
log hosts

###
/links/
[ 'http://x.com/v1/public/click/81dayvknb489',
  'http://affiliate.x.com/rd/r.php?sid=1823&pub=220662&c1=&c2=&c3=',
  'https://www.final.com/finalurl/?affid=gos&saffid=220662' ]
/hosts/
[ 'http://x.com',
  'http://affiliate.x.com',
  'https://www.final.com' ]
###
```


