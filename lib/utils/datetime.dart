import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('d MMM, yyyy');
  return formatter.format(date);
}
