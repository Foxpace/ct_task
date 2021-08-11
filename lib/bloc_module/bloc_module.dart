import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:ct_task/bloc_module/events.dart';
import 'package:ct_task/bloc_module/states.dart';
import 'package:ct_task/fhir/api_client.dart';

class BlocModule extends Bloc<ExamsEvent, ExamsState> {
  /// [httpClient] - to make calls, needs to be disposed with Bloc
  /// [StateExams.getLoading] - initial state for the Bloc
  BlocModule({required http.Client httpClient})
      : super(ExamsState.getLoading()) {
    _fhirClient = FhirClient(httpClient: httpClient);
  }

  /// [_fhirClient] - client to obtain data from fhir API
  late final FhirClient _fhirClient;

  /// temp storage for the searching queries
  String _lastSearch = "";
  bool _reversed = false;

  /// loads all the data
  void getExams() {
    add(ExamsLoad());
  }

  /// [queryInput] - string to search for
  void getSearchByNameOrId(String queryInput) {
    _lastSearch = queryInput;
    add(ExamsSearch(query: queryInput, reversed: _reversed));
  }

  /// exams will be reversed
  void getReversedList() {
    _reversed = !_reversed;
    add(ExamsSearch(query: _lastSearch, reversed: _reversed));
  }

  /// events:
  /// 1. load
  /// 2. search query
  @override
  Stream<ExamsState> mapEventToState(ExamsEvent event) async* {
    switch (event.runtimeType) {
      case ExamsLoad:
        // show loading -> show result
        yield ExamsState.getLoading();
        yield await _fhirClient.getExams(false);
        break;
      case ExamsSearch:
        yield ExamsState.getLoading();
        yield await _fhirClient.getCachedResponse(event as ExamsSearch);
        break;
    }
  }

  /// [transformEvents] - is used to manipulate Event stream
  /// the event is delayed by 500 ms - prevention of spamming events
  // @override
  // Stream<Transition<ExamsEvent, ExamsState>> transformEvents(
  //   Stream<ExamsEvent> events,
  //   TransitionFunction<ExamsEvent, ExamsState> transitionFn,
  // ) {
  //   return super.transformEvents(
  //     events.throttleTime(const Duration(milliseconds: 500)),
  //     transitionFn,
  //   );
  // }

  /// [onDispose] - to cancel all the http calls
  void onDispose() {
    _fhirClient.onDispose();
  }
}
