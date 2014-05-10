module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compiple:
        files:
          'lib/process_documentation.js':['src/*.coffee']
    mochaTest:
      options:
        reporter: 'nyan'
      src: ['test/test.coffee']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.registerTask 'default',['coffee','mochaTest']
