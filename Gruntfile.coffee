module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/process_documentation.js':['src/process_documentation.coffee'],
          'lib/modelerParser.js':['src/modelerParser.coffee']
          'lib/fileUtils.js':['src/fileUtils.coffee']
          'lib/poolParser.js':['src/poolParser.coffee']
    mochaTest:
      options:
        reporter: 'nyan'
      src: ['test/*.coffee']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.registerTask 'default',['coffee','mochaTest']
