import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselsTop extends StatefulWidget {
  const CarouselsTop({Key? key}) : super(key: key);

  @override
  State<CarouselsTop> createState() => _CarouselsTopState();
}

class _CarouselsTopState extends State<CarouselsTop> {
  final List<String> imgList = [
    'lib/assets/images/book-1.jpg',
    'lib/assets/images/book-2.jpg',
    'lib/assets/images/book-3.jpg',
  ];

  final CarouselController _carouselController = CarouselController();
  int _currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          child: Row(
            children: [
              Text(
                'Top Book of The Year',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Warna teks
                ),
              ),
              SizedBox(width: 10.0),
              Icon(
                Icons.emoji_events,
                color: Colors.yellow,
                size: 24.0,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 150.0, // Ubah tinggi carousel menjadi 150.0
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlide = index;
              });
            },
          ),
          items: imgList
              .map((item) => Container(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child:
                            Image.network(item, fit: BoxFit.cover, width: 1000),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentSlide == index ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
