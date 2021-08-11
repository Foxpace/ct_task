import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ct_task/bloc_module/events.dart';
import 'package:ct_task/fhir/filtration.dart';
import 'package:ct_task/fhir/json_types/json_patient.dart';
import 'package:ct_task/res/strings.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ct_task/bloc_module/states.dart';
import 'package:ct_task/fhir/types/examination.dart';
import 'package:ct_task/fhir/types/patient.dart';
import 'package:sprintf/sprintf.dart';

/// client to load data from fhir API
/// documentation:
/// http://hapi.fhir.org/baseR4/swagger-ui/?page=Patient#/Patient
class FhirClient {
  /// [http.Client] - to make calls on API and can be disposed later
  FhirClient({required http.Client httpClient}) : _httpClient = httpClient;

  final String _requiredQuery =
      'http://hapi.fhir.org/baseR4/Patient?_format=json';
  final http.Client _httpClient;


  /// temp storage
  List<Examination> _exams = <Examination>[];
  /// flag for success
  bool _httpCalledSuccessfully = false;

  /// [bFilterDeceased] - boolean, if the dead people should be filtered
  /// - default = true
  /// makes call to api and handles all the responses,
  /// which are mapped to States
  Future<ExamsState> getExams([bool bFilterDeceased = true]) async {
    _httpCalledSuccessfully = false;

    // check for connection
    if (Platform.isAndroid || Platform.isIOS) {
      ConnectivityResult connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return ExamsState.getNoConnection();
      }
    }

    // make call
    final http.Response response = await _getPatients();

    // pick appropriate response
    switch (response.statusCode) {
      case 200: // success
        _httpCalledSuccessfully = true;
        return _on200(response, bFilterDeceased);
      case 400:
        return ExamsState.getErrorState(message: Strings.badRequest400);
      case 401:
        return ExamsState.getErrorState(message: Strings.unauthorised401);
      case 403:
        return ExamsState.getErrorState(message: Strings.forbidden403);
      case 404:
        return ExamsState.getErrorState(message: Strings.notFound404);
      case 412:
        return ExamsState.getErrorState(message: Strings.preconditionFailed412);
      case 500:
        return ExamsState.getErrorState(
            message: Strings.internalServerError500);
      case 503:
        return ExamsState.getErrorState(message: Strings.serviceUnavailable503);
      default:
        return ExamsState.getErrorState(
            message:
                sprintf(Strings.unhandledStatus, <int>[response.statusCode]));
    }
  }

  /// calls for the patient data
  /// timeout after 60 seconds
  Future<http.Response> _getPatients() async {
    return await _httpClient
        .get(Uri.parse(_requiredQuery))
        .timeout(const Duration(seconds: 60), onTimeout: () {
      return http.Response(Strings.connectionTimedOut, 404);
    });
  }

  /// [response] - is processed to ExamsState
  /// [bFilterDeceased] - boolean, if the dead people should be filtered
  ExamsState _on200(http.Response response, bool bFilterDeceased) {
    try {
      List<Patient> patients = _parseJsonGetPatients(response.body);

      if (patients.isEmpty) return ExamsState.getEmptyState();

      // mapping and filtering of the patients
      List<Examination> exams = mapPatientsToExamination(patients);
      exams = getFilteredExams(
          exams: exams,
          searchQuery: "",
          bFilterDeceased: bFilterDeceased,
          bFilterByToday: true,
          bReversed: false);

      if (exams.isEmpty) return ExamsState.getEmptyState();

      _exams = exams;
      return ExamsState.getSuccess(exams: _exams);
    } on Error catch (e) {
      print(e.stackTrace);
      return ExamsState.getErrorState(message: Strings.errorParsing);
    }
}

  List<Patient> _parseJsonGetPatients(String body) {
    PatientResourceJson r = PatientResourceJson.fromJson(jsonDecode(body));
    return r.entry
        .map((PatientJson jsonPatient) => Patient.fromJson(jsonPatient))
        .toList();
  }

  /// artificial access to [_exams], which are filtered by
  /// [ExamsSearch] parameters from clicked event
  Future<ExamsState> getCachedResponse(ExamsSearch event) async {
    if (!_httpCalledSuccessfully) return ExamsState.getEmptyState();

    return ExamsState.getSuccess(
        exams: getFilteredExams(
            exams: _exams,
            searchQuery: event.query,
            bFilterByToday: true,
            bReversed: event.reversed,
            bFilterDeceased: true));
  }

  void onDispose() {
    _httpClient.close();
    _httpCalledSuccessfully = false;
    _exams = <Examination>[];
  }
}
