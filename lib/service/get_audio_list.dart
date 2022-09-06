// import 'dart:io';

// getFiles() async {
//   List<FileSystemEntity> _songs = [];
//   Directory dir = Directory('/storage/emulated/0/Download/');
//   String mp3Path = dir.toString();
//   print(mp3Path);

//   var _files;
//   _files = dir.listSync(recursive: true, followLinks: false);
//   for (FileSystemEntity entity in _files) {
//     String path = entity.path;
//     if (path.endsWith('.mp3')) {
//       _songs.add(entity);
//     }
//   }

//   return _songs;
// }
