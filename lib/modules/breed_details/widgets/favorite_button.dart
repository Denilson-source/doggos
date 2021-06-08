import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../breed_details_controller.dart';

class FavoriteButton extends GetView<BreedDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool? isFavorite = controller.breed.isFavorite;
      if (isFavorite == null) {
        return SizedBox();
      }

      return IconButton(
        onPressed: controller.toggleFavorite,
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      );
    });
  }
}
