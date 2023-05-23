import 'package:medico_app/models/catetory.dart';

class MedicoItem {
  MedicoCategory category;
  String title;
  DateTime date;
  MedicoItem({
    required this.category,
    required this.title,
    required this.date,
  });
}
