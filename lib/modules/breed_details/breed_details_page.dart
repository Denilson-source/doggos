import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../shared/widgets/custom_error.dart';
import 'breed_details_controller.dart';
import 'widgets/image_carrousel.dart';

class BreedDetailsPage extends GetView<BreedDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.breed.name),
      ),
      body: Column(
        children: [
          _buildImages(),
          _buildVariantsList(),
        ],
      ),
    );
  }

  Widget _buildImages() {
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

      return ImageCarrousel(images: images);
    });
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
