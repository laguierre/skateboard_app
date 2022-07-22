import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stateboard_app/data/data.dart';

import '../../constants.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key, required this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        right: kPaddingHome,
        left: kPaddingHome,
      ),
      child: Row(
        children: [
          SmoothPageIndicator(
              effect:  const SlideEffect(
                  spacing:  6.0,
                  radius:  6.0,
                  dotWidth:  12.0,
                  dotHeight:  12.0,
                  paintStyle:  PaintingStyle.stroke,
                  strokeWidth:  1,
                  dotColor:  Colors.black,
                  activeDotColor:  Colors.black
              ),
              controller: pageController, count: skateBoard.length),
          const Spacer(),
          const Text(
            'VIEW BOARD',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'lib/assets/icons/right-arrow.png',
                scale: 1,
              ))
        ],
      ),
    );
  }
}

class TopMenu extends StatelessWidget {
  const TopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        right: kPaddingHome,
        left: kPaddingHome,
      ),
      child: Row(
        children: [
          const Text(
            'Hops',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 30,
              )),
        ],
      ),
    );
  }
}
