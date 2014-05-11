assert = require 'assert'
should = require('chai').should()
expect = require('chai').expect
fs = require 'fs'
_ = require 'lodash'
util = require 'util'
pDoc = require('../lib/process_documentation.js')

fileUtils = require('../lib/fileUtils')

fixtures = fs.readdirSync 'fixtures'

folders = _.filter fixtures, (item) ->
  fs.lstatSync(process.cwd() + "/fixtures/" + item).isDirectory()

for folder in folders
  diagram = "fixtures/" + folder
  do (diagram) ->
    describe "ProcessDocumentation", ->
      it "Parse the diagram", (done) ->
        fileUtils.getProcessFiles diagram, (err,data) ->
          documentation = new pDoc(data)
          documentation.parse ()->
             expect(documentation.pools).to.not.be.undefined
             expect(documentation.pools).to.have.length.above(1)
             console.log(util.inspect(documentation.pools, { showHidden: true, depth: null }))
             done()
      # it "can process the FirstDiagram fixture from data", (done) ->
      #   documentation = new pDoc()
      #   documentation.parseFiles diagram, (err, data) ->
      #      expect(documentation.pools).to.not.be.undefined
      #      expect(documentation.pools).to.have.length.above(1)
      #      # console.log(util.inspect(documentation.pools, { showHidden: true, depth: null }))
      #      done()
