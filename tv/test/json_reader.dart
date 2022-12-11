import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
//CHANGE 'tv/test' TO 'test' if running the tv test from the tv folder with "flutter test --coverage"
  if (dir.endsWith('test')) {
    dir = dir.replaceAll('test', '');
  }
  return File('$dir/test/$name').readAsStringSync();
}
