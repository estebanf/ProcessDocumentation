_ = require 'lodash'

class ModelerParser
  constructor: (modelerData) ->
    @data = modelerData

  parse: (cb) ->
    pools = _.map @data['bpmn:BpmnDiagram'].pools, (item) ->
      poolData = item['$']
      pool = { id:poolData.iD, name:poolData.name, doc:poolData.documentation }
      return pool
    cb(pools)

module.exports = ModelerParser
