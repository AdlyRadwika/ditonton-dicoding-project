import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
//TODO: CHANGE 'tv/test' TO 'test' if running the tv test from the tv folder with "flutter test --coverage"
  if (dir.endsWith('tv/test')) {
    dir = dir.replaceAll('tv/test', '');
  }
  return File('$dir/tv/test/$name').readAsStringSync();
}
