import 'dart:math';

import 'package:ct_task/fhir/types/patient.dart';
import 'package:ct_task/res/images.dart';
import 'package:ct_task/res/strings.dart';
import 'package:sprintf/sprintf.dart';

class Examination {
  /// [patient] - patient data
  /// [hours] - indexes of patients to create random exam dates
  Examination({required this.patient, required int hours}) {
    final Random random = Random();

    examinationType =
        ExaminationTypes.values[random.nextInt(ExaminationTypes.values.length)];

    // min is 20 min, max is 1h
    dateTime = DateTime.now()
        .add(Duration(hours: hours, minutes: random.nextInt(40) + 20));
  }

  final Patient patient;
  late final ExaminationTypes examinationType;
  late final DateTime dateTime;

  @override
  String toString() {
    return sprintf(Strings.examinationToString, <String>[
      dateTime.toString(),
      examinationType.toString(),
      patient.toString()
    ]);
  }
}

/// List<Patient> -> List<Examination>
List<Examination> mapPatientsToExamination(List<Patient> patients) {
  return Iterable<int>.generate(patients.length)
      .map((int idx) => Examination(patient: patients[idx], hours: idx))
      .toList();
}

/// exam types, which can have text and image
enum ExaminationTypes { ctAbdomen, ctChest, ctPelvis }

extension ExamintationTypesExtension on ExaminationTypes {
  String getText(ExaminationTypes type) {
    switch (type) {
      case ExaminationTypes.ctAbdomen:
        return Strings.ctAbdomen;
      case ExaminationTypes.ctChest:
        return Strings.ctChest;
      case ExaminationTypes.ctPelvis:
        return Strings.ctPelvis;
    }
  }

  String getAsset(ExaminationTypes type) {
    switch (type) {
      case ExaminationTypes.ctAbdomen:
        return Images.ctAbdomen;
      case ExaminationTypes.ctChest:
        return Images.ctChest;
      case ExaminationTypes.ctPelvis:
        return Images.ctPelvis;
    }
  }
}
