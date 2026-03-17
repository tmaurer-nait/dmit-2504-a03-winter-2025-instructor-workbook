import 'package:flutter/material.dart';
import 'package:camera_example/pages/gallery_page.dart';

// flutter pub add camera
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({required this.cameraDescription, super.key});

  final CameraDescription cameraDescription;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();

    // Creates my camera controller, pointing it at the camera I want to use
    _cameraController = CameraController(
      widget.cameraDescription,
      ResolutionPreset.max,
    );

    // intialize camera controller getting permissions as needed
    _cameraController
        .initialize()
        .then((_) {
          // Camera permission has been granted, no errors
          // We call an empty set state to force a rebuild of the page
          setState(() {
            // If we wanted to we could set camera presets here
          });
        })
        .catchError((e) {
          // error happened check what it was
          if (e is CameraException && e.code == 'CameraAccessDenied') {
            // The user has said no to camera permissions, decide how to handle it
            // you could re-ask, shut down app, show error UI, etc.
            throw Exception('Camera Permission Denied');
          }
        });
  }

  @override
  void dispose() {
    // dispose controller to prevent memory leaks
    _cameraController.dispose();
    super.dispose();
  }

  Future<XFile?> _takePicture() async {
    // make sure we aren't already taking a picture
    if (_cameraController.value.isTakingPicture) return null;

    // try to take the picture
    try {
      // by default taking a picture stores the file in your local cache folder
      // We return that here and then later on could move it, rename it, etc.
      // Or just leave it where it is and read from there
      final file = await _cameraController.takePicture();
      return file;
    } catch (e) {
      // handle issues here
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Contains the button to navigate to gallery page
      appBar: AppBar(),
      // Camera Preview, showing what the camera sees
      body: Center(child: CameraPreview(_cameraController)),
      // Take a picture button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var file = await _takePicture();

          // Once you've take a picture make sure it actually worked
          // and that we're still mounted
          if (file != null && mounted) {
            // Here you could move the photo, rename it, show some feedback
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Picture saved to: ${file.path}')),
            );
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
