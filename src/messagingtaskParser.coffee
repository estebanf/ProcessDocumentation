_ = require 'lodash'

class MessagingtaskParser
  constructor: (container,scopeData)->
    @container = container
    @data = scopeData

  parse: (errCallback, doneCallback) ->
    msgMetadata = @data['$']

    msgData = {}
    msgData.name = msgMetadata['bpdm:label']
    msgData.type = "Task" unless msgMetadata['eventType']
    msgData.type = "Start event" if msgMetadata['eventType'] and msgMetadata['eventType'] == "start: message"
    msgData.documentation = msgMetadata['bpdm:documentation'] if msgMetadata['bpdm:documentation']

    @container.push msgData
    doneCallback()

module.exports = MessagingtaskParser  
