# TODO - require common?
gulp        = require 'gulp'
concat      = require 'gulp-concat'
plumber     = require 'gulp-plumber'
livereload  = require 'gulp-livereload'

# Import Paths
paths = require './paths.coffee'

# Concat
gulp.task 'concat', ->
  stream = gulp.src([
      paths.node_modules + 'jquery/dist/jquery.js'
      paths.node_modules + 'underscore/underscore.js'
      paths.node_modules + 'backbone/backbone.js'
      paths.node_modules + 'backbone.babysitter/lib/backbone.babysitter.js'
      paths.node_modules + 'backbone.wreqr/lib/backbone.wreqr.js'
      paths.node_modules + 'backbone.marionette/lib/core/backbone.marionette.js'
      paths.node_modules + 'backbone-metal/dist/backbone-metal.js'
      paths.node_modules + 'backbone-routing/dist/backbone-routing.js'
      paths.node_modules + 'backbone.radio/build/backbone.radio.js'
      paths.node_modules + 'marionette-service/dist/marionette-service.js'
      paths.node_modules + 'tether/dist/js/tether.min.js'
      paths.node_modules + 'bootstrap/dist/js/bootstrap.min.js'
    ])
    # .pipe plumber()
    .pipe concat('vendor.js')
    .pipe livereload()

  # TODO - Env.
  # stream.pipe uglify() if environment == 'production'
  stream.pipe gulp.dest paths.dest + 'js/'
