module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      libs:
        options:
          sourceMap: true
        files:
          'public/lib.js': ['assets/js/lib/*.coffee']

    copy:
      main:
        files: [
          { expand: true, flatten: true, src: 'assets/js/vendor/jquery/jquery.js', dest: 'public/' }
          { expand: true, flatten: true, src: 'assets/js/vendor/typeahead.js/dist/typeahead.js', dest: 'public/' }
        ]

    uglify:
      slikflik:
        options:
          # sourceMapIn: 'public/lib.js.map'
          sourceMap: 'public/slikflik.js.map'
          sourceMappingURL: 'slikflik.js.map'
          sourceMapPrefix: 1

        files:
          'public/slikflik.js': [
            'public/jquery.js'
            'public/typeahead.js'
            'public/lib.js'
          ]

    watch:
      src:
        files: ['assets/js/lib/*.coffee']
        tasks: ['build']

  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', ['copy', 'coffee', 'uglify']
