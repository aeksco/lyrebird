gulp = require 'gulp'

# Paths config

nodeModules = './node_modules/'

paths =
  src:          './app/'
  dest:         './www/'
  node_modules: './node_modules/'
  jadeSrc:      './app/index.jade'

  bundle:
    src: 'coffee/app.coffee'
    dest: 'app.js'

  sass:
    src:  './app/sass/app.sass'
    dest: './www/css/'

  onsen_ui:
    src:  './node_modules/onsenui/css/onsenui.css'
    dest: './www/css'

  onsen_ui_components:
    src:  './node_modules/onsenui/css/onsen-css-components.css'
    dest: './www/css'

  onsen_ui_icons:
    font_awesome:
      src:  './node_modules/onsenui/css/font_awesome/**/*'
      dest: './www/css/font_awesome'

    ionicons:
      src:  './node_modules/onsenui/css/ionicons/**/*'
      dest: './www/css/ionicons'

    material:
      src:  './node_modules/onsenui/css/material-design-iconic-font/**/*'
      dest: './www/css/material-design-iconic-font'

  concat:
    dest: 'vendor.js'
    src: [
      nodeModules + 'jquery/dist/jquery.js'
      nodeModules + 'underscore/underscore.js'
      nodeModules + 'backbone/backbone.js'
      nodeModules + 'backbone.babysitter/lib/backbone.babysitter.js'
      nodeModules + 'backbone.wreqr/lib/backbone.wreqr.js'
      nodeModules + 'backbone.marionette/lib/core/backbone.marionette.js'
      nodeModules + 'backbone-metal/dist/backbone-metal.js'
      nodeModules + 'backbone-routing/dist/backbone-routing.js'
      nodeModules + 'backbone.radio/build/backbone.radio.js'
      nodeModules + 'marionette-service/dist/marionette-service.js'
      nodeModules + 'backbone.syphon/lib/backbone.syphon.js'
      # nodeModules + 'tether/dist/js/tether.min.js'
      # nodeModules + 'bootstrap/dist/js/bootstrap.min.js'
      # nodeModules + 'bootstrap-switch/dist/js/bootstrap-switch.min.js'
      nodeModules + 'crypto-js/crypto-js.js'
      nodeModules + 'backbone.dualStorage/backbone.dualStorage.js'
      nodeModules + 'bluebird/js/browser/bluebird.min.js'
      # nodeModules + 'hammerjs/hammer.js'
      # nodeModules + 'swiper/dist/js/swiper.jquery.min.js'
      nodeModules + 'onsenui/js/onsenui.js'
    ]

# Import Plugins
plugins = require 'gulp_tasks/gulp/config/plugins'
plugins.browserify = require 'gulp-browserify'

# Import tasks
require('gulp_tasks/gulp/tasks/env')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/copy')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/sass')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/jade')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/watch')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/webserver')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/noop')(gulp, paths, plugins)
require('../gulp/shared')(gulp, paths, plugins)

# Watch Task
gulp.task 'watch', ->
  gulp.watch paths.src + '**/*.coffee',  ['bundle']
  gulp.watch paths.src + '**/*.jade',    ['bundle', 'jade']
  gulp.watch paths.src + '**/*.sass',    ['sass']

# # # # #
# Onsen UI Asset Tasks

# Copy Onsen UI
gulp.task 'copy_onsen_ui', ->
  gulp.src paths.onsen_ui.src
    .pipe plugins.plumber()
    .pipe gulp.dest(paths.onsen_ui.dest)

# Copy Onsen UI Component
gulp.task 'copy_onsen_ui_components', ->
  gulp.src paths.onsen_ui_components.src
    .pipe plugins.plumber()
    .pipe gulp.dest(paths.onsen_ui_components.dest)

# Copy Onsen UI FontAwesome
gulp.task 'copy_onsen_ui_icons_fa', ->
  gulp.src paths.onsen_ui_icons.font_awesome.src
    .pipe plugins.plumber()
    .pipe gulp.dest(paths.onsen_ui_icons.font_awesome.dest)

# Copy Onsen UI Ionicons
gulp.task 'copy_onsen_ui_icons_ionicons', ->
  gulp.src paths.onsen_ui_icons.ionicons.src
    .pipe plugins.plumber()
    .pipe gulp.dest(paths.onsen_ui_icons.ionicons.dest)

# Copy Onsen UI Material Icons
gulp.task 'copy_onsen_ui_icons_material', ->
  gulp.src paths.onsen_ui_icons.material.src
    .pipe plugins.plumber()
    .pipe gulp.dest(paths.onsen_ui_icons.material.dest)

gulp.task 'onsen_ui_assets', ['copy_onsen_ui', 'copy_onsen_ui_components', 'copy_onsen_ui_icons_fa', 'copy_onsen_ui_icons_ionicons', 'copy_onsen_ui_icons_material']

# # # # #

# Build tasks
gulp.task 'default', ['dev']

gulp.task 'dev', =>
  plugins.runSequence.use(gulp)('env_dev', 'sass', 'jade', 'onsen_ui_assets', 'concat', 'bundle', 'watch', 'webserver')

gulp.task 'release', =>
  plugins.runSequence.use(gulp)('env_prod', 'sass', 'jade', => console.log 'release completed.' )
