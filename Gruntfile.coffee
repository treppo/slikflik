module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      libs:
        options:
          sourceMap: true
        files:
          'public/js/lib.js': ['assets/js/*.coffee']

    copy:
      vendor:
        expand: true
        flatten: true
        src: [
          'assets/vendor/jquery/jquery.js'
          'assets/vendor/typeahead.js/dist/typeahead.js'
        ]
        dest: 'public/js/'

    uglify:
      slikflik:
        options:
          # sourceMapIn: 'public/lib.js.map'
          sourceMap: 'public/core.js.map'
          sourceMappingURL: 'slikflik.js.map'
          sourceMapPrefix: 1

        files:
          'public/slikflik.js': [
            'public/js/jquery.js'
            'public/js/typeahead.js'
            'public/js/lib.js'
          ]

    sass:
      slikflik:
        files:
          'public/slikflik.css': 'assets/css/core.sass'

    watch:
      src:
        files: [
          'assets/js/*.coffee'
          'assets/css/core.sass'
          'Gruntfile.coffee'
        ]
        tasks: ['build']

  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', ['copy', 'coffee', 'uglify', 'sass']
