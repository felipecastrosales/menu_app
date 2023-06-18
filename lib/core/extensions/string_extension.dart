import 'package:diacritic/diacritic.dart';

extension StringX on String {
  String get clear => removeDiacritics(toLowerCase());
}
