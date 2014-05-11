_ = require 'lodash'
scopeParser = require './scopeParser'

class PoolParser
  constructor: (pool,poolData)->
    @pool = pool
    @data = poolData

  parse: (errCallback, doneCallback) ->
    scope =  @data['bpel:process']['bpel:scope'][0]
    parser = new scopeParser(@pool,scope)
    parser.parse errCallback, (err,data) ->
      errCallback(err) if err

      doneCallback(data)  


module.exports = PoolParser