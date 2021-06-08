class Breed {
  String name;
  bool? isFavorite;
  List<String>? variants;
  List<String>? images;

  Breed({
    required this.name,
    this.isFavorite,
    this.variants,
    this.images,
  });
}
