class Film {
  // Properties
  late final String id;
  late final String title;
  late final String description;

  // Constructors
  Film({required this.id, required this.title, required this.description});
  // Same as the following:
  // Film({
  //   required String id,
  //   required String title,
  //   required String description,
  // }) {
  //   this.id = id;
  //   this.title = title;
  //   this.description = description;
  // }

  factory Film.fromJSON(dynamic jsonFilm) {
    return Film(
      description: jsonFilm['description'],
      title: jsonFilm['title'],
      id: jsonFilm['id'],
    );
  }

  // Methods
  @override
  String toString() {
    return '$title is a film where $description';
  }
}
