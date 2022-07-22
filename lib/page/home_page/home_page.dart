import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stateboard_app/data/data.dart';
import 'dart:math' as math;
import '../../constants.dart';
import 'home_page_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  PageController pageController = PageController(viewportFraction: 1.25);
  double pageValue = 0;
  int currentPage = 0;
  int direction = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    pageController.addListener(() {
      setState(() {
        for (pageValue = pageController.page!; pageValue > 1;) {
          (pageValue--);
        }
        currentPage = pageController.page!.truncate();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          children: [
            const TopMenu(),
            Expanded(
              child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  itemCount: skateBoard.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          top: 0,
                          left: kPaddingHome * kFactorPage,
                          right: kPaddingHome * kFactorPage,
                          bottom: 180,
                          child: Transform.scale(
                            scale: currentPage == index
                                ? pageValue != 1.0
                                    ? 1 - pageValue
                                    : 1
                                : pageValue,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            top: 10,
                            child: Transform.rotate(
                              angle: currentPage > index
                                  ? -math.pi / 2 * 4 * pageValue
                                  : math.pi / 2 * 4 * pageValue,
                              child: Opacity(
                                opacity: currentPage != index
                                    ? (2.5 * pageValue).clamp(0, 1)
                                    : 1,
                                child: Center(
                                    child: Transform.scale(
                                  scale:
                                      currentPage != index ? pageValue : 1.0,
                                  child: Container(
                                    width: size.width * 0.4,
                                    height: size.height * 0.55,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          topRight: Radius.circular(100),
                                          bottomLeft: Radius.circular(100),
                                          bottomRight: Radius.circular(100)),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 15,
                                            offset: const Offset(5,
                                                3) // changes position of shadow
                                            ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      skateBoard[index].image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )),
                              ),
                            )),
                        Positioned(
                            top: index == currentPage
                                ? size.height * (0.5 + 0.1)
                                : size.height * (0.5 + 0.1 * pageValue),
                            // top: size.height * 0.6 + 10,
                            child: Opacity(
                              opacity: currentPage == index
                                  ? pageValue != 1.0
                                      ? 1 - (3.5 * pageValue).clamp(0, 1)
                                      : 1
                                  : pageValue,
                              child: Text(
                                skateBoard[index].name,
                                style: GoogleFonts.merriweather(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 34),
                              ),
                            )),
                        Positioned(
                            left: (kFactorPage - 1) * kPaddingHome,
                            right: (kFactorPage - 1) * kPaddingHome,
                            top: currentPage == index
                                ? (size.height * 0.6 + 10 + 60)
                                : (size.height * 0.6 +
                                    10 +
                                    60 * pageValue * pageValue),
                            // top: (size.height * 0.6 + 10 + 60),
                            child: Opacity(
                              opacity: currentPage == index
                                  ? pageValue != 1.0
                                      ? 1 - (3.5 * pageValue).clamp(0, 1)
                                      : 1.0
                                  : pageValue,
                              child: Text(
                                skateBoard[index].description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )),
                      ],
                    );
                  }),
            ),
            BottomMenu(pageController: pageController),
          ],
        ));
  }
}
