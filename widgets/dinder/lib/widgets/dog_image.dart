import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DogImage extends StatefulWidget {
  const DogImage({super.key});

  final endpoint = 'https://dog.ceo/api/breeds/image/random';

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
      setState(() {
        // update the dog url inside of setState
        _dogImageUrl = newDogUrl;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    loadNewDog();
  }

  // helper build method to make the actual build cleaner to read
  Widget _buildImage() {
    return _dogImageUrl.isEmpty
        ? SizedBox(
            height: 600,
            child: Center(child: CircularProgressIndicator()),
          )
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
            child: Image.network(_dogImageUrl, height: 600, fit: BoxFit.cover),
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
