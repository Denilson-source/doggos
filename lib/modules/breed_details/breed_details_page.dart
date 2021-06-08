import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../shared/widgets/custom_error.dart';
import 'breed_details_controller.dart';
import 'widgets/favorite_button.dart';

class BreedDetailsPage extends GetView<BreedDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.breed.name),
        actions: [FavoriteButton()],
      ),
      body: Column(
        children: [
          _buildVariantsList(),
          Expanded(child: _buildImagesGrid()),
        ],
      ),
    );
  }

  Widget _buildImagesGrid() {
    return Obx(() {
      final state = controller.state;

      if (state.isLoading) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: SpinKitThreeBounce(
              color: Get.theme.primaryColor,
              size: 22,
            ),
          ),
        );
      }

      if (state.hasError) {
        return CustomError.withAction(
          error: 'something went wrong',
          actionLabel: 'refresh',
          action: controller.fetchImages,
        );
      }

      List<String> images = controller.breed.images ?? [];
      if (state.hasData && images.isEmpty) {
        return CustomError(
          error: 'No image was found',
        );
      }

      if (images.isEmpty) {
        return SizedBox();
      }

      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${images.length} images found',
              style: Get.textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: images.length,
                itemBuilder: (context, index) => _buildGridItem(
                  image: images[index],
                  index: index,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildGridItem({required String image, required int index}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.showImageCarrousel(index),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildVariantsList() {
    List<String> variants = controller.breed.variants ?? [];
    if (variants.isEmpty) {
      return SizedBox();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Variants',
            style: Get.textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                variants.map((e) => _buildVariantListItem(name: e)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantListItem({required String name}) {
    return Container(
      constraints: BoxConstraints(minWidth: 50),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
