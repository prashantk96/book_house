import 'package:auto_route/auto_route.dart';
import 'package:book_house/features/auth/presentation/pages/login_page.dart';
import 'package:book_house/features/auth/presentation/pages/create_account.dart';
import 'package:book_house/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:book_house/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:book_house/features/onboarding/presentation/pages/success_page.dart';
import 'package:book_house/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: SuccessRoute.page),
    AutoRoute(page: DashboardRoute.page),
  ];
}
