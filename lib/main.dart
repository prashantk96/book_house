import 'package:book_house/app.dart';
import 'package:book_house/core/services/local_storage_service.dart';
import 'package:book_house/di/injection.dart';
import 'package:book_house/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:book_house/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Dependency Injection
  configureDependencies();

  // Initialize Local Storage
  await sl<LocalStorageService>().init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<OnboardingBloc>(create: (_) => sl<OnboardingBloc>()),
      ],
      child: const App(),
    ),
  );
}
