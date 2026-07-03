
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc
    extends Bloc<
        ProfileEvent,
        ProfileState
    > {

    ProfileBloc()
        : super(
            ProfileInitial(),
          ) {

        on<LoadProfile>(
            _onLoad,
        );
    }

    Future<void> _onLoad(
        LoadProfile event,
        Emitter<
            ProfileState
        > emit,
    ) async {

    }
}
