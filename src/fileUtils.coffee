fs = require 'fs'
path = require 'path'
xml2js = require 'xml2js'
_ = require 'lodash'

exports.getProcessFiles = (process,cb) ->
  fs.readdir process, (err,results) ->
    cb(err) if err

    processFiles = []

    files = _.filter results, (item) ->
      bpmn = /.+\.bpmn$/
      bpdm = /.+\.bpdm$/
      return bpmn.test(item) or bpdm.test(item)

    done = _.after files.length, () ->
      cb(null,processFiles)
    

    _.each files, (file) ->
      fs.readFile path.join(process,file), (err, result) ->
        cb(err) if err

        xml2js.parseString result, (err, data) ->

          cb(err) if err
          
          processFiles.push {file:file,data:data}

          done()
