
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc
    extends Bloc<
        SearchEvent,
        SearchState
    > {

    SearchBloc()
        : super(
            SearchInitial(),
          ) {

        on<LoadSearch>(
            _onLoad,
        );
    }

    Future<void> _onLoad(
        LoadSearch event,
        Emitter<
            SearchState
        > emit,
    ) async {

    }
}
