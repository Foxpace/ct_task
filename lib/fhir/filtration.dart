import 'package:ct_task/fhir/types/examination.dart';

/// merged filter functions into one
/// search by query from searchbar [searchQuery], deceased [bFilterDeceased],
/// today's day [bFilterByToday] and reversed list [bReversed]
List<Examination> getFilteredExams(
    {required List<Examination> exams,
    required String searchQuery,
    required bool bFilterByToday,
    required bool bFilterDeceased,
    required bool bReversed}) {

  if (bFilterByToday) exams = filterByToday(exams);
  if (bFilterDeceased) exams = filterOutDeceased(exams);
  if (searchQuery != "") exams = filterByQuery(exams, searchQuery);
  if (bReversed) exams = exams.reversed.toList();

  return exams;
}

/// filtration based on [Patient]'s deceased boolean
List<Examination> filterOutDeceased(List<Examination> exams) {
  return exams
      .where((Examination examination) => !examination.patient.deceased)
      .toList();
}

/// filters out examination from other days
List<Examination> filterByToday(List<Examination> exams) {
  DateTime now = DateTime.now();
  return exams
      .where((Examination exam) => exam.dateTime.day == now.day)
      .toList();
}

/// checks, if any id or name from [exams] list contains the [query]
List<Examination> filterByQuery(List<Examination> exams, String query) {
  return exams
      .where((Examination exam) =>
          exam.patient.name.toLowerCase().contains(query.toLowerCase()) ||
          exam.patient.id.contains(query))
      .toList();
}
