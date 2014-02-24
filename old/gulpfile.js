var gulp = require('gulp');

var istanbul = require('gulp-istanbul');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');

var paths = {
  scripts: [
    'src/**/*.coffee'
  ],
  tests: [
    'test/**/*.coffee'
  ],
  images: 'client/img/**/*'
};

var mocha = require('gulp-mocha');
var cover = require('gulp-coverage');

gulp.task('test', function () {
  gulp.src(['build/js/all.min.js'], { read: false })
  .pipe(cover.instrument({
    pattern: ['**/test*'],
  debugDirectory: 'debug'
  }))
  .pipe(mocha({
  }))
  .pipe(cover.report({
    outFile: 'coverage.html'
  }));
});

gulp.task('scripts', function() {
  // Minify and copy all JavaScript (except vendor scripts)
  return gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(concat('all.min.js'))
    .pipe(gulp.dest('build/js'));
});

// Rerun the task when a file changes
gulp.task('watch', function () {
  gulp.watch('gulpfile.js', paths.scripts, ['scripts', 'test']);
});


// The default task (called when you run `gulp` from cli)
gulp.task('default', ['scripts', 'test', 'watch']);

