assert = require 'assert'
should = require('chai').should()
processDocumentation = require '../lib/process_documentation.js'

describe 'processDocumentation', ->
  it 'first test', ->
    x = 1
    x.should.be.equal 1