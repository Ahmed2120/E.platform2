import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'welcome_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();

  int currentPage = 1;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: PageView(
              onPageChanged: (val){
                print(val);
                currentPage = val + 1;
              },
              controller: controller,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/video-courses.png'),
                      const Text('دورات الفيديو', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),),
                      const Text('خذ أفضل دورات الفيديو على الإنترنت', style: TextStyle(color: Colors.black) ,textAlign: TextAlign.center,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/expert.png'),
                      const Text('معلمون خبراء', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),),
                      const Text(' تعلم من المعلمون الخبراء الذين يتمتعون بالمعرفة الجيدة والشغف بالتدريس.', style: TextStyle(color: Colors.black) ,textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 2,
                    effect:  WormEffect(
                        dotWidth: 5,
                        dotHeight: 5,
                        dotColor: const Color(0xFF3AA091).withOpacity(0.5) ,
                        activeDotColor:  const Color(0xFF368075)
                    ),
                  ),
                ),
                TextButton(onPressed: (){
                  GlobalMethods.navigateReplace(context, const WelcomePage());
                }, child: const Text('تخطى', style: TextStyle(color: Colors.black),)),
                GestureDetector(
                  onTap: (){
                    if(currentPage == 2) {
                      GlobalMethods.navigateReplace(context, const WelcomePage());
                    }
                    else{
                      controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white, // border color
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryColor, )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4), // border width
                      child: Container( // or ClipRRect if you need to clip the content
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor, // inner circle color
                        ),
                        child: const Icon(Icons.arrow_forward, color: Colors.white,), // inner content
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
