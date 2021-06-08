import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCarrousel extends StatefulWidget {
  final List<String> images;
  final int? initialIndex;

  ImageCarrousel({required this.images, this.initialIndex});

  @override
  _ImageCarrouselState createState() => _ImageCarrouselState();
}

class _ImageCarrouselState extends State<ImageCarrousel>
    with TickerProviderStateMixin {
  TabController? tabController;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: widget.initialIndex ?? 0,
      length: widget.images.length,
      vsync: this,
    );

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    tabController!.addListener(() {
      setState(() {});
    });

    animationController!.forward();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Get.height * 0.5,
        child: Material(
          color: Colors.transparent,
          child: SizeTransition(
            sizeFactor: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
              parent: animationController!,
              curve: Curves.fastLinearToSlowEaseIn,
            )),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  // height: 300,
                  // color: Colors.red,
                  child: TabBarView(
                    controller: tabController,
                    children: widget.images.map((e) => _buildImage(e)).toList(),
                  ),
                ),
                SizedBox(height: 10),
                _buildIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String image) {
    return CachedNetworkImage(
      imageUrl: image,
    );
  }

  Widget _buildIndicator() {
    return Container(
      height: 20,
      constraints: BoxConstraints(maxWidth: 80),
      child: Row(
        children: [
          Container(
            width: 25,
            child: Text(
              '${tabController!.index + 1}',
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 5),
          Text(
            '/',
            style: Get.textTheme.bodyText1!.copyWith(
              color: Colors.white,
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 25,
            child: Text(
              '${tabController!.length}',
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
