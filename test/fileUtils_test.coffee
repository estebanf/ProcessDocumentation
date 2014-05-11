assert = require 'assert'
should = require('chai').should()
expect = require('chai').expect

fileUtils = require('../lib/fileUtils')

describe "FileUtils", ->
  it "can process the FirstDiagram fixture", (done)->
    fileUtils.getProcessFiles 'fixtures/FirstDiagram.bpm', (err,data) ->
      expect(data.length).to.be.equal(3)
      done()
    