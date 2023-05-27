class MedicoItem {
  String medImagePath;
  String name;
  String dosage;
  String beforeOrAfterFood;
  DateTime medicationStartDate;
  DateTime medicationEndDate;
  List<DateTime> reminders;
  MedicoItem({
    required this.medImagePath,
    required this.name,
    required this.dosage,
    required this.beforeOrAfterFood,
    required this.medicationStartDate,
    required this.medicationEndDate,
    required this.reminders,
  });
}
