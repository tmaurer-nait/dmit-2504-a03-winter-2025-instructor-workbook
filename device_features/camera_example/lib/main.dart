import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:camera_example/pages/camera_page.dart';

void main() async {
  // Ensure widget tree is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Ask the device for the cameras that are available
  var cameras = await availableCameras();

  runApp(MainApp(cameras: cameras));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.cameras, super.key});

  // list of all cameras on the device, pick one to pass to the page
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    // Pick the first camera and pass it through to the camera page for preview and pictures
    return MaterialApp(home: CameraPage(cameraDescription: cameras[0]));
  }
}
