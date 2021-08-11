class Strings {
  // app strings
  static const String appTitle = "Task CT";
  static const String ct1 = "CT1";

  // exam list strings
  static const String searchBoxHint = "Search patient name, ID, DOB";
  static const String menu = "Menu";
  static const String addExam = "Add exam";
  static const String reverseList = "Reverse list";
  static const String filterList = "Filter list";
  static const String countOfPatientsToday = "Today, All (%d)";
  static const String deleteExam = "Delete examination";
  static const String nameForm = "%s, %s";
  static const String examBirthDateGenderId = "*%s, %s %s";
  static const String exam = "Examination";

  // exam tab
  static const String dateFormat = "h:mm a dd/MM/yyyy";

  // error handling
  static const String tryAgain = "Try again";

  // exam types
  static const String ctPelvis = "CT pelvis";
  static const String ctAbdomen = "CT abdomen";
  static const String ctChest = "CT chest";

  // states
  static const String noExams = "No examinations today!";
  static const String ok = "OK";
  static const String yes = "yes";
  static const String no = "no";
  static const String loading = "Loading";
  static const String noInternet = "Check your internet connection";
  static const String connectionTimedOut = "Error - connection timed out";
  static const String errorParsing =
      "Error occurred during the parsing of the json";
  static const String stateToString = "Message: %s\n\nStatus:\n%s";
  static const String emptyList = "Exams are empty!";

  // patients
  static const String femaleFull = "female";
  static const String maleFull = "male";
  static const String female = "F";
  static const String male = "M";
  static const String unknownGender = "U";
  static const String unknown = "Unknown";
  static const String dashedUnknown = " - Unknown";
  static const String printPatient = "ID: %s, name: %s, birthDay: %s, "
      "gender: %s, deceased: %s";

  // patient fields
  static const String patientEntry = "entry";
  static const String patientResources = "resource";
  static const String patientId = "id";
  static const String patientName = "name";
  static const String patientBirthDate = "birthDate";
  static const String patientGender = "gender";
  static const String patientDeceasedDateTime = "deceasedDateTime";
  static const String patientNameUse = "use";
  static const String patientUrl = "fullUrl";

  // patient name types
  static const String patientNameOfficial = "official";
  static const String patientNameText = "text";
  static const String patientNameGiven = "given";
  static const String patientNameFamily = "family";

  // http status
  static const String unhandledStatus = "Unhandled status: %d";
  static const String badRequest400 = "Invalid request form client";
  static const String unauthorised401 = "Client authentication failed";
  static const String forbidden403 =
      "Licking authorisation for these resources";
  static const String notFound404 = "Resources are not reachable";
  static const String preconditionFailed412 =
      "One or more header fields evaluated to false";
  static const String internalServerError500 = "Error occurred on server";
  static const String serviceUnavailable503 =
      "Requested service is not available";

  static const String examinationToString =
      "Date: %s\nExaminationType: %s\nPatient data:\n%s";
}
