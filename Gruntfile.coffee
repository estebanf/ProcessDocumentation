module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compiple:
        files:
          'lib/process_documentation.js':['src/*.coffee']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.registerTask 'default',['coffee']