#ldjson-keys

Pipe LDJSON in, get all of the keys found out.

This is useful in conjunction with `maxogden/csv-write-stream` that reads CSV columns from first row/object only.

![Build Status](http://img.shields.io/codeship/bf2e7930-638b-0132-0720-76d0773b13a7.svg?style=flat)
[![Dependencies](http://img.shields.io/david/radekstepan/ldjson-keys.svg?style=flat)](https://david-dm.org/radekstepan/ldjson-keys)
[![License](http://img.shields.io/badge/license-AGPL--3.0-red.svg?style=flat)](LICENSE)

##Run

Install with [npm](https://www.npmjs.org/).

```bash
$ npm install ldjson-to-csv -g
```

By default you get new-line delimited output:

```bash
$ echo '{"col1":1}\n{"col2":2}' | ldjson-to-csv
# col1
# col2
```

##Source

    _         = require 'highland'
    ndjson    = require 'ndjson'
    { EOL }   = require 'os'
    HashTable = require 'hashtable'

    module.exports = ->
      keys = new HashTable()

      through = (obj) ->
        _ (push, next) ->
          for k of obj when not keys.has k
            keys.put k, null
            push null, k + EOL
          do next

      _.pipeline.apply _, [
        do _
        do ndjson.parse
        _.map through
        _.parallel 50
      ]