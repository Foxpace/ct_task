// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:ct_task/bloc_module/bloc_module.dart';
import 'package:ct_task/bloc_module/events.dart';
import 'package:ct_task/bloc_module/states.dart';

Future<void> main() async {

  test('Bloc test - get patients from API', () async {
    BlocModule module = BlocModule(httpClient: http.Client());
    await for(ExamsState state in module.mapEventToState(ExamsLoad())){
      switch(state.status){
        case StatusTypes.loading:
          print("Loading");
          break;
        case StatusTypes.success:
          state.exams.forEach((examintation) {print(examintation);});
          expect(state.exams.length, greaterThan(0));
          break;
        case StatusTypes.empty:
        case StatusTypes.error:
        case StatusTypes.noConnection:
          fail(state.message);
      }
    }
  });

}
