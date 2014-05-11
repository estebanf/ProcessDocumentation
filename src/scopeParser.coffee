_ = require 'lodash'

class ScopeParser
  constructor: (container,scopeData)->
    @container = container
    @data = scopeData

  parse: (errCallback, doneCallback) ->
    scopeMetadata = @data['$']

    scopeData = {}
    scopeData.name = scopeMetadata['bpdm:label']
    scopeData.documentation = scopeMetadata['bpdm:documentation'] if scopeMetadata['bpdm:documentation']
    scopeData.sequence = []

    sequence = @data['bpel:sequence'][0]

    done = _.after _.keys(sequence).length , () =>
      @container.scopes = [] if !@container.scopes
      @container.scopes.push scopeData
      doneCallback()

    _.forIn sequence, (value,key,object) ->
      parserKey = key.split(':')[1] + "Parser"
      try
          parserLib = require('./' + parserKey)
          parser = new parserLib(scopeData.sequence, value[0])
          parser.parse errCallback, done
      catch e
        throw e unless e.code and e.code.match(/MODULE_NOT_FOUND/)
        console.log "Don't know how to parse ", parserKey
        done()

module.exports = ScopeParser
  
