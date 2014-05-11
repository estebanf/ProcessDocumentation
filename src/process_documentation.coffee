mParser = require './modelerParser'
fileUtils = require './fileUtils'
poolParser = require './poolParser'
_ = require('lodash')

class ProcessDocumentation
  constructor: (processData) ->
    @data = processData
  parseFiles: (path,callback) ->
    fileUtils.getProcessFiles path, (err,data) =>
      callback(err) if err

      @data = data

      @parse callback

  parse: (callback) ->
    callback("Process data not available") if !@data

    modeler = _.find @data, (item) ->
      return item.file == "modeler.bpmn"

    callback("modeler.bpmn not found") if !modeler

    modelerParser = new mParser(modeler.data)
    modelerParser.parse (parsedPools) =>
      @pools = parsedPools
      @parsePools(callback)
  
  parsePools: (cb) ->
    done = _.after @pools.length, (data) ->
      cb(null, data)

    _.each @pools, (pool) =>
      poolData = _.find @data, (item) ->
        item.file == pool.id + ".bpdm"

      parser = new poolParser(pool,poolData.data)
      parser.parse cb,done

module.exports = ProcessDocumentation