import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  //TODO: change 'movie/test' TO 'test' if running the movie test from the movie folder with "flutter test --coverage"
  if (dir.endsWith('movie/test')) {
    dir = dir.replaceAll('movie/test', '');
  }
  return File('$dir/movie/test/$name').readAsStringSync();
}
