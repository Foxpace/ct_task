import 'dart:math';

import 'package:ct_task/fhir/json_types/json_patient.dart';
import 'package:ct_task/res/strings.dart';
import 'package:sprintf/sprintf.dart';

/// [Patient] - holds all the necessary data about patient at examination
/// [id] - id of the patient
/// [name] - name of the patient
/// [birthDay] - birthDay of the patient
/// [gender] - gender of the patient
/// [deceased] - if the patient is dead

class Patient {
  Patient(
      {required this.id,
      required this.name,
      required this.birthDay,
      required this.gender,
      required this.deceased,
      required this.fullUrl});

  /// [Patient.fromJson] - parsing of the response from the fhir client
  /// [patientJson] - decoded response body by [jsonDecode]
  /// - entries from resources
  factory Patient.fromJson(PatientJson patientJson) {
    String id = _checkLengthId(patientJson.resource.id);
    return Patient(
        id: id,
        name: _validateName(_getName(id, patientJson.resource.name)),
        birthDay: _getBirthDate(patientJson),
        gender: _genderCoding(patientJson.resource.gender),
        deceased: _isDeceased(patientJson),
        fullUrl: patientJson.fullUrl);
  }

  final String id;
  final String name;
  final String birthDay;
  final String gender;
  final String? fullUrl;
  final bool deceased;

  @override
  String toString() => sprintf(Strings.printPatient, <String>[
        id,
        name,
        birthDay,
        gender,
        deceased ? Strings.yes : Strings.no
      ]);
}

const int _maxNameSize = 20;
const int _maxRandomIdSize = 10;

/// if the [id] is too long -> max [_maxRandomIdSize] chars
/// if the [id] is null -> generate new random
String _checkLengthId(String id) {
  if (id.length > _maxRandomIdSize) {
    return id.substring(0, _maxRandomIdSize);
  } else if (id.isEmpty) {
    return _generateRandomId();
  }
  return id;
}

/// generates random ID string with size of [_maxRandomIdSize]
String _generateRandomId() {
  Random random = Random();
  String newId = "";
  for (int i = 0; i < _maxRandomIdSize; i += 1) {
    newId += random.nextInt(_maxRandomIdSize).toString();
  }
  return newId;
}

/// codes [gender] full names into gender code 'F/M/U'
String _genderCoding(String gender) {
  switch (gender.toLowerCase()) {
    case Strings.maleFull:
      return Strings.male;
    case Strings.femaleFull:
      return Strings.female;
    default:
      return Strings.unknownGender;
  }
}

/// picks the best name if it is possible from [nameVariations]
/// Processing of the name:
/// 1. name is "" - generated [id] + "- Unknown"
/// 2. name is presented -> trying to find the official name of the person
/// or given name
/// 3. name is presented - no official name -> picking first available name
/// 4. name can be in form of text of independent field, picking text as first
/// 5. checking, if the name is no longer than [_maxNameSize] chars -
/// trimming with '...' and adding

String _getName(String id, List<PatientNameVariationJson> nameVariations) {
  String bestPick = id + Strings.dashedUnknown;
  if (nameVariations.isEmpty) return bestPick;

  for (PatientNameVariationJson nameVariation in nameVariations) {
    if (nameVariation.type == Strings.patientNameOfficial) {
      if (nameVariation.text != "") return nameVariation.text;

      if (nameVariation.given.isNotEmpty) {
        return _getGivenName(nameVariation);
      }
    } else {
      // picking first available name
      if (nameVariation.text != "") {
        bestPick = nameVariation.text;
        continue;
      }

      if (nameVariation.given.isNotEmpty) {
        bestPick = _getGivenName(nameVariation);
      }
    }
  }

  return bestPick;
}

/// [_getGivenName] - joins given name and family name if available
String _getGivenName(PatientNameVariationJson jsonName) {
  String partOfName = jsonName.given[0];
  if (jsonName.family != "") partOfName = " " + jsonName.family;
  return partOfName;
}

/// [_validateName] - if the name is longer than 20 chars - trimming
/// name and surname are switched and divided by ', ' - except for unknowns
/// only surname -> 'Surname'
String _validateName(String name) {
  if (name.length > _maxNameSize) {
    return name.substring(0, _maxNameSize) + "...";
  }

  if (name.contains(Strings.dashedUnknown)) return name;

  List<String> split =
      name.split(" ").where((String s) => s.isNotEmpty).toList();

  if (split.length == 1) return split.first;

  return sprintf(Strings.nameForm, <String>[split[1], split[0]]);
}

/// returns the birthDate, if available, otherwise 'unknown'
String _getBirthDate(PatientJson jsonPatient) =>
    jsonPatient.resource.birthDate != ""
        ? jsonPatient.resource.birthDate
        : Strings.unknown;

/// the patient is dead, if the time is available
bool _isDeceased(PatientJson jsonPatient) =>
    jsonPatient.resource.deceasedDateTime != "";