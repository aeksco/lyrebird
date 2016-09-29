gulp = require 'gulp'
paths = require './gulp/paths.coffee'
webserver = require 'gulp-webserver'


# Import tasks
require './gulp/coffee.coffee'
require './gulp/copy.coffee'
require './gulp/concat.coffee'
require './gulp/sass.coffee'
require './gulp/jade.coffee'

# Webserver Task
gulp.task 'webserver', ->
  gulp.src paths.dest
    .pipe webserver
      port: 8080
      open: true

# Watch & Live Reload
gulp.task 'watch', ->
  # livereload.listen
  #   host: 'localhost'
  #   port: 4000
  #   start: true
  #   reloadPage: paths.dest + 'index.html'

  gulp.watch paths.src + 'coffee/**', ['coffee']
  gulp.watch paths.src + 'coffee/**/*.jade', ['coffee']
  gulp.watch paths.src + 'stylesheets/**/*.sass', ['sass']
  gulp.watch paths.src + '**/*.jade', ['jade']

# Task declarations
gulp.task 'default', ['sass', 'jade', 'copy', 'coffee', 'concat', 'watch', 'webserver']
