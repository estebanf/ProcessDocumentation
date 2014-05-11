_ = require 'lodash'

class PoolParser
  constructor: (pool,poolData)->
    @pool = pool
    @data = poolData

  parse: (errCallback, doneCallback) ->
    scope =  @data['bpel:process']['bpel:scope']
    console.log scope[0]['bpel:sequence']
    # for key in scope
    #   console.log key['bpel:sequence']
    console.log '============'

    doneCallback()  


module.exports = PoolParser