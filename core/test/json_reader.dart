import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('core/test')) {
    dir = dir.replaceAll('core/test', '');
  }
  return File('$dir/core/test/$name').readAsStringSync();
}
