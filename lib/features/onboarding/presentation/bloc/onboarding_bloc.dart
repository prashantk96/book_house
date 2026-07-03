import 'package:book_house/core/services/local_storage_service.dart';
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:book_house/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final LocalStorageService storage;

  OnboardingBloc(this.storage) : super(OnboardingInitial()) {
    on<CheckOnboardingStatus>(_check);

    on<CompleteOnboarding>(_complete);
  }

  Future<void> _check(
    CheckOnboardingStatus event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());

    final completed = await storage.isOnboardingCompleted();

    if (completed) {
      emit(OnboardingCompleted());
    } else {
      emit(OnboardingNotCompleted());
    }
  }

  Future<void> _complete(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    await storage.completeOnboarding();

    emit(OnboardingCompleted());
  }
}
