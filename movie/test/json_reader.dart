import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('movie/test')) {
    dir = dir.replaceAll('movie/test', '');
  }
  return File('$dir/movie/test/$name').readAsStringSync();
}
