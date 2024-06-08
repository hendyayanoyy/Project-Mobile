// ignore_for_file: depend_on_referenced_packages, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopBook extends StatefulWidget {
  const TopBook({Key? key}) : super(key: key);

  @override
  State<TopBook> createState() => _TopBookState();
}

class _TopBookState extends State<TopBook> {
  final List<String> imgList = [
    'lib/assets/images/topbook-1.png',
    'lib/assets/images/topbook-2.png',
    'lib/assets/images/topbook-3.png',
  ];

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const Text(
            'Top Books',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 250.0,
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 16 / 9,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                // _currentSlide = index;
              });
            },
          ),
          items: imgList
              .map((item) => Container(
                    // padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Stack(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey, // Warna border
                                  width: 1.0, // Ketebalan border
                                ),
                              ),
                              child: Image.network(
                                item,
                                fit: BoxFit.cover,
                                height: 250.0,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 5.0,
                          right: 5.0,
                          child: Icon(
                            Icons.bookmark,
                            color: Colors.blue,
                            size: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
