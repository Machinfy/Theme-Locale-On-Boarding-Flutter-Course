import 'package:flutter/material.dart';
import 'package:on_boarding_app/core/extenstion/context_extension.dart';
import 'package:on_boarding_app/core/network/local/cache_helper.dart';
import 'package:on_boarding_app/models/on_boarding_data.dart';
import 'package:on_boarding_app/screens/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();
  var _isLastPageReached = false;
  final _onBoardings = [
    OnBoardingData(
        image: 'assets/images/on boarding1.jpg',
        pageBody:
            'This is long on boarding page body to be displayed in page 1',
        pageTitle: 'Page Title 1'),
    OnBoardingData(
        image: 'assets/images/on boarding1.jpg',
        pageBody:
            'This is long on boarding page body to be displayed in page 2',
        pageTitle: 'Page Title 2'),
    OnBoardingData(
        image: 'assets/images/on boarding1.jpg',
        pageBody:
            'This is long on boarding page body to be displayed in page 3',
        pageTitle: 'Page Title 3')
  ];

  void skipOnBoarding() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
    CacheHelper.setData(key: 'boarded', value: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                skipOnBoarding();
              },
              child: Text(context.loc.skip))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index) => PageViewItem(
                  data: _onBoardings[index],
                ),
                itemCount: _onBoardings.length,
                onPageChanged: (currentIndex) {
                  if (currentIndex == _onBoardings.length - 1) {
                    _isLastPageReached = true;
                  } else {
                    _isLastPageReached = false;
                  }
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.green, dotColor: Colors.grey),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isLastPageReached) {
            // TODO:- Navigate From On Boarding
            skipOnBoarding();
          } else {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          }
        },
        child: const Icon(Icons.arrow_forward_outlined),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.data});

  final OnBoardingData data;
  @override
  Widget build(BuildContext context) {
    const gabV10 = SizedBox(height: 10);

    return Column(
      children: [
        Expanded(flex: 6, child: Image.asset(data.image)),
        gabV10,
        Expanded(
          flex: 1,
          child: Text(
            data.pageTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        gabV10,
        Expanded(
          flex: 2,
          child: Text(
            data.pageBody,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
