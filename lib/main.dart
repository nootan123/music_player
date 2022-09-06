import 'package:flutter/material.dart';
import 'package:player/home.dart';
import 'package:player/provider/media_controller_provider.dart';
import 'package:player/service/get_file_read_permission.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding();
  GetPermission().getFileReadWritePermission();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MediaControllerProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    ),
  );
}
