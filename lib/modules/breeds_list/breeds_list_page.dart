import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../shared/model/breed.dart';
import '../../shared/widgets/custom_error.dart';
import 'breeds_list_controller.dart';

class BreedsListPage extends GetView<BreedsListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breeds'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Obx(() {
      final state = controller.state;
      if (state.isLoading) {
        return Center(
          child: SpinKitThreeBounce(
            color: Get.theme.primaryColor,
            size: 22,
          ),
        );
      }

      if (state.hasError) {
        return CustomError.withAction(
          error: 'Something went wrong',
          action: controller.fetchBreeds,
          actionLabel: 'Refresh',
        );
      }

      List<Breed> breeds = controller.breeds;
      if (breeds.isEmpty) {
        return CustomError(error: 'No breeds was found');
      }

      return ListView.builder(
        itemCount: breeds.length,
        itemBuilder: (context, index) => _buildListItem(breeds[index]),
      );
    });
  }

  Widget _buildListItem(Breed breed) {
    return ListTile(
      onTap: () => controller.toBreedImages(breed),
      title: Text(breed.name),
      trailing: Icon(Icons.arrow_right),
    );
  }
}
