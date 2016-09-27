gulp        = require 'gulp'
sass        = require 'gulp-sass'
minifyCss   = require 'gulp-minify-css'
rename      = require 'gulp-rename'
plumber     = require 'gulp-plumber'
livereload  = require 'gulp-livereload'

# Import Paths
paths = require './paths.coffee'

# Compile SASS / SCSS
gulp.task 'sass', =>
  gulp.src paths.src + 'stylesheets/app.sass'
    .pipe plumber()
    .pipe sass()
    .pipe minifyCss({ keepSpecialComments: 0 })
    .pipe rename({ extname: '.min.css' })
    .pipe gulp.dest( paths.dest + 'css/')
    .pipe livereload()
