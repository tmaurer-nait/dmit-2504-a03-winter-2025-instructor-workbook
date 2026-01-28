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
  var _dogImageUrl = '';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _dogImageUrl.isEmpty
            ? SizedBox(
                height: 600,
                child: Center(child: CircularProgressIndicator()),
              )
            : Image.network(_dogImageUrl, height: 600),
        ElevatedButton(onPressed: loadNewDog, child: Text('Go Fetch!')),
      ],
    );
  }
}
