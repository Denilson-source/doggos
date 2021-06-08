import '../utils/types.dart';

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

  factory Breed.fromJson(Json data) {
    List<String>? variants;
    if (data['variants'] != null) {
      variants = data['variants'].split(',');
    }

    return Breed(
      name: data['name'],
      variants: variants,
    );
  }

  Json toJson() {
    return {
      'name': this.name,
      if (this.variants?.isNotEmpty ?? false)
        'variants': this.variants!.join(','),
    };
  }
}
