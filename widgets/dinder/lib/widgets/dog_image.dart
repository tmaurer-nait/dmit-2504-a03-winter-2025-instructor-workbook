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

  @override
  Widget build(BuildContext context) {
    return Column(children: [Image.network(_dogImageUrl)]);
  }
}
