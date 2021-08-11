import 'package:ct_task/fhir/types/examination.dart';
import 'package:ct_task/res/strings.dart';
import 'package:sprintf/sprintf.dart';

/// possible types of state
enum StatusTypes { loading, success, error, empty, noConnection }

/// state main class
/// naming convention should be --> BlocSubject + Verb (action) + State
class ExamsState {
  /// [status] - of StatusTypes class - refers to actual state
  /// [exams] - list of exams to show - can be empty
  /// [message] - in case of error - this message can be shown
  ExamsState(
      {required this.status, required this.exams, required this.message});

  /// use, if the examinations are empty
  factory ExamsState.getEmptyState() => ExamsState(
      status: StatusTypes.empty,
      exams: <Examination>[],
      message: Strings.noExams);

  /// use, if the error occurred
  factory ExamsState.getErrorState({required String message}) => ExamsState(
      status: StatusTypes.error, exams: <Examination>[], message: message);

  /// use, if the data were obtained successfully
  factory ExamsState.getSuccess({required List<Examination> exams}) =>
      ExamsState(
          status: StatusTypes.success, exams: exams, message: Strings.ok);

  /// use, while you are waiting for the result
  factory ExamsState.getLoading() => ExamsState(
      status: StatusTypes.loading,
      exams: <Examination>[],
      message: Strings.loading);

  /// use, if there is no connection
  factory ExamsState.getNoConnection() => ExamsState(
      status: StatusTypes.noConnection,
      exams: <Examination>[],
      message: Strings.noInternet);

  final StatusTypes status;
  final List<Examination> exams;
  final String message;

  ExamsState copyWith(
          StatusTypes? status, List<Examination>? exams, String? message) =>
      ExamsState(
          status: status ?? this.status,
          exams: exams ?? this.exams,
          message: message ?? this.message);

  @override
  String toString() {
    return sprintf(Strings.stateToString, <String>[message, status.toString()]);
  }
}
