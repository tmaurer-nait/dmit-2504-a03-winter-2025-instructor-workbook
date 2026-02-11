import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// flutter pub add path_provider
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DogImage extends StatefulWidget {
  const DogImage({super.key, required this.endpoint});

  final String endpoint;

  @override
  State<DogImage> createState() => _DogImageState();
}

class _DogImageState extends State<DogImage> {
  // Stateful variables
  var _dogImageUrl = '';
  var _likes = 0;
  var _dislikes = 0;

  // Normally we would put this in a services file
  Future<String> getRandomDogUrl() async {
    // Parse the URI
    final uri = Uri.parse(widget.endpoint);

    // Make the request and await the response
    final res = await http.get(uri);

    // Decode the response and return
    return jsonDecode(res.body)['message'];
  }

  // Helper function to update the dog image
  void loadNewDog() {
    setState(() {
      _dogImageUrl = '';
    });
    // Fetch dog url using other helper function
    getRandomDogUrl().then((newDogUrl) {
      // Make sure the widget is still in the tree at the end of the async call
      if (!mounted) return;
      // call set state to trigger a redraw

      // Call the save helper method with the newDogUrl
      _cacheDogImage(newDogUrl);

      setState(() {
        // update the dog url inside of setState
        _dogImageUrl = newDogUrl;
      });
    });
  }

  // A helper function to save the last seen dog image
  void _cacheDogImage(String url) async {
    // Fetch the image data from the url and await the response
    final res = await http.get(Uri.parse(url));

    // Get the temporary directory (async)
    final dir = await getTemporaryDirectory();

    // Create the file path
    final filePath = '${dir.path}/lastSeenDog.jpg';

    // Open the file
    final file = File(filePath);

    // Write the image data to the file
    file.writeAsBytesSync(res.bodyBytes);
  }

  @override
  void initState() {
    super.initState();

    // TODO: Check if there is a cached dog image, if so show it
    // else loadNewDog();
    getTemporaryDirectory().then((dir) {
      // Once the temp dir is open, check if the cached dog exists
      final file = File('${dir.path}/lastSeenDog.jpg');
      if (file.existsSync()) {
        // If so set the state to show that cached image
        setState(() {
          _dogImageUrl = '${dir.path}/lastSeenDog.jpg';
        });
      } else {
        // Else load a new dog
        loadNewDog();
      }
    });
  }

  // helper build method to make the actual build cleaner to read
  Widget _buildImage() {
    // Update this to load images from files as needed

    // We need to check on the state of the image url. There are 3 possible cases:
    // 1: Empty Image Url -> CircularProgressInidicator()
    // 2: Url is a online resource -> Image.network
    // 3: Url is a local file path -> Image.file

    late Widget childWidget;

    if (_dogImageUrl.trim().isEmpty) {
      childWidget = CircularProgressIndicator();
    } else if (_dogImageUrl.startsWith('http')) {
      childWidget = Image.network(_dogImageUrl, height: 600, fit: BoxFit.cover);
    } else {
      childWidget = Image.file(
        File(_dogImageUrl),
        height: 600,
        fit: BoxFit.cover,
      );
    }

    return _dogImageUrl.isEmpty
        ? SizedBox(height: 600, child: Center(child: childWidget))
        : GestureDetector(
            onDoubleTap: () {
              setState(() {
                _likes++;
              });
              loadNewDog();
            },
            onLongPress: () {
              setState(() {
                _dislikes++;
              });
              loadNewDog();
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity != null &&
                  details.primaryVelocity! > 0) {
                setState(() {
                  _likes++;
                });
                loadNewDog();
              } else {
                setState(() {
                  _dislikes++;
                });
                loadNewDog();
              }
            },
            child: childWidget,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImage(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Likes: $_likes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Dislikes: $_dislikes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _dislikes++;
            });
            loadNewDog();
          },
          child: Text('Dislike'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _likes++;
            });
            loadNewDog();
          },
          child: Text('Like'),
        ),
        ElevatedButton(onPressed: loadNewDog, child: Text('Go Fetch!')),
      ],
    );
  }
}
