import 'package:json_annotation/json_annotation.dart';

part 'json_patient.g.dart';

/// classes for the json decoding
/// for automatic code generation for json serializable:
/// -> flutter pub run build_runner build
///
/// Structure:
/// Response
/// (PatientResourceJson)
///  -> entry (list of our patients)
///     (PatientJson)
///     -> fullUrl - String
///     -> resource - patient information
///         (PatientDataJson)
///         -> id - String
///         (PatientNameVariationJson)
///         -> name - list - patient can have multiple names
///           -> given - list, names used by patient
///           -> family - surname
///           -> text - name to use/show
///           -> type - 'official'
///           -> id
///         -> birthDate - String
///         -> deceasedDateTime - String
///         -> gender - String
///

@JsonSerializable()
class PatientResourceJson {
  PatientResourceJson(this.entry);

  factory PatientResourceJson.fromJson(Map<String, dynamic> json) =>
      _$PatientResourceJsonFromJson(json);

  Map<String, dynamic> toJson() => _$PatientResourceJsonToJson(this);

  @JsonKey(required: true)
  List<PatientJson> entry;
}

@JsonSerializable()
class PatientJson {
  PatientJson(this.fullUrl, this.resource);

  factory PatientJson.fromJson(Map<String, dynamic> json) =>
      _$PatientJsonFromJson(json);

  Map<String, dynamic> toJson() => _$PatientJsonToJson(this);
  @JsonKey(required: true)
  PatientDataJson resource;
  @JsonKey(defaultValue: "")
  String fullUrl;
}

@JsonSerializable()
class PatientDataJson {
  PatientDataJson(
      this.id, this.name, this.gender, this.birthDate, this.deceasedDateTime);

  factory PatientDataJson.fromJson(Map<String, dynamic> json) =>
      _$PatientDataJsonFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDataJsonToJson(this);

  @JsonKey(defaultValue: "")
  String id;
  @JsonKey(defaultValue: <String>[])
  List<PatientNameVariationJson> name;
  @JsonKey(defaultValue: "")
  String gender;
  @JsonKey(defaultValue: "")
  String birthDate;
  @JsonKey(defaultValue: "")
  String deceasedDateTime;
}

@JsonSerializable()
class PatientNameVariationJson {
  PatientNameVariationJson(
      this.text, this.given, this.id, this.family, this.type);

  factory PatientNameVariationJson.fromJson(Map<String, dynamic> json) =>
      _$PatientNameVariationJsonFromJson(json);

  Map<String, dynamic> toJson() => _$PatientNameVariationJsonToJson(this);

  @JsonKey(defaultValue: "")
  String text;
  @JsonKey(defaultValue: <String>[])
  List<String> given;
  @JsonKey(defaultValue: "")
  String id;
  @JsonKey(defaultValue: "")
  String family;
  @JsonKey(defaultValue: "")
  String type;
}
