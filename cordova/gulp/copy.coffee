gulp        = require 'gulp'
jade        = require 'gulp-jade'
plumber     = require 'gulp-plumber'
livereload  = require 'gulp-livereload'

# Import Paths
paths = require './paths.coffee'

# Copy Tasks
gulp.task 'copy', ['copy_fontawesome', 'copy_images']

# Copy FontAwesome fonts
gulp.task 'copy_fontawesome', ->
  gulp.src paths.node_modules + 'font-awesome/fonts/*'
    .pipe plumber()
    .pipe gulp.dest paths.dest + 'fonts/'
    .pipe livereload()

# Copy Images
gulp.task 'copy_images', ->
  gulp.src paths.src + 'img/*'
    .pipe plumber()
    .pipe gulp.dest paths.dest + 'img/'
    .pipe livereload()
