import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateTimeFormatter {
  static const _DISPLAY_FORMAT = "MMM d,yyyy h:mm a";

  static String getDisplayDateTime(Timestamp timestamp) {
    return DateFormat(_DISPLAY_FORMAT).format(timestamp.toDate());
  }
}
