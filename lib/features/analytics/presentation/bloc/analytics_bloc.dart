
import 'package:flutter_bloc/flutter_bloc.dart';

import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc
    extends Bloc<
        AnalyticsEvent,
        AnalyticsState
    > {

    AnalyticsBloc()
        : super(
            AnalyticsInitial(),
          ) {

        on<LoadAnalytics>(
            _onLoad,
        );
    }

    Future<void> _onLoad(
        LoadAnalytics event,
        Emitter<
            AnalyticsState
        > emit,
    ) async {

    }
}
