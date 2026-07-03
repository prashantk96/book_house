import 'package:auto_route/auto_route.dart';
import 'package:book_house/routes/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SuccessPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const SuccessPage({
    super.key,
    this.title = 'Success',
    this.subtitle =
        'Your account is ready to use. You will be redirected to the home page in a few seconds.',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),

              // Success Icon
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xff4B68FF).withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 100,
                    color: Color(0xff4B68FF),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff202244),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff545454),
                  height: 1.6,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    // context.replaceRoute(const HomeRoute());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4B68FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
