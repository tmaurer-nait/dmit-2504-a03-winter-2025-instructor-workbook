import 'package:flutter/material.dart';

// flutter pub add path_provider
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> _photoPaths = [];

  @override
  void initState() {
    super.initState();
    // Get the cache directory
    getApplicationCacheDirectory().then((dir) {
      setState(() {
        // get all the files in that directory
        final fileList = dir.listSync().toList();

        // for each file, if it's a jpg, add the path to the state
        for (var file in fileList) {
          if (file.path.endsWith('jpg')) _photoPaths.add(file.path);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, idx) {
          final path = _photoPaths[idx];
          return ListTile(
            leading: Image.file(File(path), height: 50, width: 50),
            title: Text(path),
          );
        },
        itemCount: _photoPaths.length,
      ),
    );
  }
}
