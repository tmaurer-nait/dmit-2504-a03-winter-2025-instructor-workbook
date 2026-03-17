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
  }

  @override
  void dispose() {
    // dispose controller to prevent memory leaks
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
