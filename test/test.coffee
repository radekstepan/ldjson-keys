{ assert } = require 'chai'
_          = require 'highland'
ndjson     = require 'ndjson'
{ EOL }    = require 'os'

through = require '../README.coffee.md'

module.exports =
  'keys': (done) ->
    arr = [
      { "col1": 1 }
      { "col2": 2, "col1": 3 }
    ]

    expected = [ "col1", "col2" ]

    _(arr)
    .pipe(do ndjson.stringify)
    .pipe(do through)
    .toArray (res) ->
      assert.deepEqual res, expected.map (key) -> key + EOL
      do done