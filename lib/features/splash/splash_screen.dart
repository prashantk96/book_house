import 'package:auto_route/auto_route.dart';
import 'package:book_house/features/auth/presentation/bloc/auth_state.dart';
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:book_house/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/presentation/bloc/auth_bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    context.read<OnboardingBloc>().add(CheckOnboardingStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          final user = context.read<AuthBloc>().state;

          if (user is AuthAuthenticated) {
            // context.router.replace(const HomeRoute());
          } else {
            context.router.replace(const LoginRoute());
          }
        }

        if (state is OnboardingNotCompleted) {
          context.router.replace(const OnboardingRoute());
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
