import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget customSlider({
  required List<Widget> childList,
  double? height,
  double? aspectRatio,
  bool? autoPlay,
  CarouselSliderController? carouselController,
  dynamic Function(int, CarouselPageChangedReason)? onPageChanged,
  void Function(double?)? onScrolled,
}) {
  return CarouselSlider.builder(
    carouselController: carouselController,
    itemCount: childList.length,
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        childList[itemIndex],
    options: CarouselOptions(
      height: height,
      // aspectRatio: 16 / 9,
      // aspectRatio: aspectRatio ?? 16 / 9,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: autoPlay ?? true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: false,
      enlargeFactor: 0.0,
      scrollDirection: Axis.horizontal,
      onPageChanged: onPageChanged,
      onScrolled: onScrolled,
    ),
  );
}
