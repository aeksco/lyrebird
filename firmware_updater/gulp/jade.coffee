gulp        = require 'gulp'
jade        = require 'gulp-jade'
plumber     = require 'gulp-plumber'
livereload  = require 'gulp-livereload'

# Import Paths
paths = require './paths.coffee'

# Compile jade
gulp.task 'jade', ->
  gulp.src paths.src + 'index.jade'
    .pipe plumber()
    # .pipe jade({ pretty: environment == 'development' }) # TODO - Env.
    .pipe jade({ pretty: true })
    .pipe gulp.dest paths.dest
    .pipe livereload()
