import 'package:auto_route/auto_route.dart';
import 'package:book_house/core/services/local_storage_service.dart';
import 'package:book_house/di/injection.dart';
import 'package:book_house/features/onboarding/data/models/onboarding_model.dart';
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:book_house/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pageController = PageController();

  bool isLast = false;

  final pages = [
    const OnboardingModel(
      title: 'Numerous free trial courses',
      subtitle: 'Free courses for you to find your way to learning',
      image: 'assets/images/onboarding1.png',
    ),

    const OnboardingModel(
      title: 'Quick and easy earning',
      subtitle:
          'Easy and fast learning at any time to help you improve various skills',
      image: 'assets/images/onboarding2.png',
    ),

    const OnboardingModel(
      title: 'Create your own study plan',
      subtitle: 'Study according to the study plan, make study more motivated',
      image: 'assets/images/onboarding3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          context.replaceRoute(const LoginRoute());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(CompleteOnboarding());
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      isLast = index == pages.length - 1;
                    });
                  },
                  itemBuilder: (_, index) {
                    final item = pages[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          const Spacer(),

                          // Image
                          SizedBox(
                            height: 260,
                            child: Image.asset(item.image, fit: BoxFit.contain),
                          ),

                          const SizedBox(height: 50),

                          // Title
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff202244),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Subtitle
                          Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff545454),
                              height: 1.6,
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: WormEffect(
                  activeDotColor: const Color(0xff4B68FF),
                  dotColor: Colors.grey.shade300,
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                ),
              ),

              const SizedBox(height: 40),

              if (isLast)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.replaceRoute(const SignUpRoute());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4B68FF),
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.replaceRoute(const LoginRoute());
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 55),
                            side: const BorderSide(color: Color(0xff4B68FF)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Log in',
                            style: TextStyle(color: Color(0xff4B68FF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                SizedBox(height: 55, child: Container()),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
