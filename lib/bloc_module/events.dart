enum EventTypes { loadPatientsEvent }

/// naming convention -> BlocSubject + Noun (optional) + Verb (event)
/// Event abstract object
abstract class ExamsEvent {}

/// to load exams from API
class ExamsLoad extends ExamsEvent{}

/// to pass input from searchbar
class ExamsSearch extends ExamsEvent{
  ExamsSearch({required this.query, required this.reversed});
  final String query;
  final bool reversed;
}

