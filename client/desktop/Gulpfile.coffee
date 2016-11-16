gulp = require 'gulp'

# Paths config

nodeModules = './node_modules/'

paths =
  src:          './app/'
  dest:         './build/'
  node_modules: './node_modules/'
  sassSrc:      './app/sass/app.sass'
  jadeSrc:      './app/index.jade'

  manifest:
    src:  'manifest.coffee'
    dest: 'package.json'

  bundle:
    src: 'coffee/app.coffee'
    dest: 'app.js'

  server_bundle:
    src: 'coffee/server.coffee'
    dest: 'server.js'

  sass:
    src:  'sass/app.sass'
    dest: 'app.css'

  concat:
    dest: 'vendor.js'
    src: [
      nodeModules + 'jquery/dist/jquery.js'
      nodeModules + 'bluebird/js/browser/bluebird.js'
      nodeModules + 'underscore/underscore.js'
      nodeModules + 'backbone/backbone.js'
      nodeModules + 'backbone.babysitter/lib/backbone.babysitter.js'
      nodeModules + 'backbone.wreqr/lib/backbone.wreqr.js'
      nodeModules + 'backbone.marionette/lib/core/backbone.marionette.js'
      nodeModules + 'backbone-metal/dist/backbone-metal.js'
      nodeModules + 'backbone-routing/dist/backbone-routing.js'
      nodeModules + 'backbone.radio/build/backbone.radio.js'
      nodeModules + 'marionette-service/dist/marionette-service.js'
      nodeModules + 'tether/dist/js/tether.min.js'
      nodeModules + 'bootstrap/dist/js/bootstrap.min.js'
    ]

# Import Plugins
plugins = require 'gulp_tasks/gulp/config/plugins'
plugins.browserify = require 'gulp-browserify'

# Import tasks
require('gulp_tasks/gulp/tasks/env')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/copy')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/sass')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/jade')(gulp, paths, plugins)
# require('gulp_tasks/gulp/tasks/watch')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/webserver')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/noop')(gulp, paths, plugins)
require('../gulp/shared')(gulp, paths, plugins)

# # # # #

# Compiles NodeWebKit package.json manifest
gulp.task 'manifest', ->

  writeManifest = ->
    manifest = require(paths.src + paths.manifest.src)
    plugins.fs.writeFile( paths.dest + paths.manifest.dest, manifest )
    # plugins.fs.writeFile(paths.manifest.dest, manifest)

  plugins.fs.exists paths.dest, (exists) ->
    if exists
      writeManifest()
    else
      plugins.fs.mkdir paths.dest, -> writeManifest()

# Watch Task
gulp.task 'watch', ->
  gulp.watch paths.src + '**/*.coffee',  ['bundle', 'server_bundle']
  gulp.watch paths.src + '**/*.jade',    ['bundle', 'server_bundle', 'jade']
  gulp.watch paths.src + '**/*.sass',    ['sass']

# # # # #

# Build tasks
gulp.task 'default', ['dev']

gulp.task 'dev', =>
  plugins.runSequence.use(gulp)('env_dev', 'sass', 'jade', 'manifest', 'bundle', 'server_bundle', 'watch', 'webserver')

gulp.task 'release', =>
  plugins.runSequence.use(gulp)('env_prod', 'copy', 'sass', 'jade', 'manifest', => console.log 'release completed.' )
