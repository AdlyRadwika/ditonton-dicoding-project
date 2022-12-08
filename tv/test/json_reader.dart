import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('tv/test')) {
    dir = dir.replaceAll('tv/test', '');
  }
  return File('$dir/tv/test/$name').readAsStringSync();
}
