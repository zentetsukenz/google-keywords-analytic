'use strict';

var gulp  = require('gulp');
var del   = require('del');

var appConfig = {
  app: require('./bower.json').appPath || 'app',
  dist: 'dist'
};

gulp.task('default', function() {
  // place code for your default task here
});

gulp.task('build', ['clean']);

gulp.task('clean', function (cb) {
  del([
    appConfig.dist + '/**/*'
  ], cb);
});
