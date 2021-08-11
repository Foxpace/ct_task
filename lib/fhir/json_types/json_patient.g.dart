// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientResourceJson _$PatientResourceJsonFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['entry'],
  );
  return PatientResourceJson(
    (json['entry'] as List<dynamic>)
        .map((e) => PatientJson.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PatientResourceJsonToJson(
        PatientResourceJson instance) =>
    <String, dynamic>{
      'entry': instance.entry,
    };

PatientJson _$PatientJsonFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['resource'],
  );
  return PatientJson(
    json['fullUrl'] as String? ?? '',
    PatientDataJson.fromJson(json['resource'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PatientJsonToJson(PatientJson instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'fullUrl': instance.fullUrl,
    };

PatientDataJson _$PatientDataJsonFromJson(Map<String, dynamic> json) =>
    PatientDataJson(
      json['id'] as String? ?? '',
      (json['name'] as List<dynamic>?)
              ?.map((e) =>
                  PatientNameVariationJson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['gender'] as String? ?? '',
      json['birthDate'] as String? ?? '',
      json['deceasedDateTime'] as String? ?? '',
    );

Map<String, dynamic> _$PatientDataJsonToJson(PatientDataJson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
      'deceasedDateTime': instance.deceasedDateTime,
    };

PatientNameVariationJson _$PatientNameVariationJsonFromJson(
        Map<String, dynamic> json) =>
    PatientNameVariationJson(
      json['text'] as String? ?? '',
      (json['given'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      json['id'] as String? ?? '',
      json['family'] as String? ?? '',
      json['type'] as String? ?? '',
    );

Map<String, dynamic> _$PatientNameVariationJsonToJson(
        PatientNameVariationJson instance) =>
    <String, dynamic>{
      'text': instance.text,
      'given': instance.given,
      'id': instance.id,
      'family': instance.family,
      'type': instance.type,
    };
