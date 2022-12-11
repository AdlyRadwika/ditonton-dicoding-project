import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  //CHANGE 'movie/test' TO 'test' if running the movie test from the movie folder
  if (dir.endsWith('movie/test')) {
    dir = dir.replaceAll('movie/test', '');
  }
  return File('$dir/movie/test/$name').readAsStringSync();
}
