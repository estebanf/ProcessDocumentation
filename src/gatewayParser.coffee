_ = require 'lodash'

class GatewayParser
  constructor: (container,scopeData)->
    @container = container
    @data = scopeData

  parse: (errCallback, doneCallback) ->
    console.log @data
    doneCallback()