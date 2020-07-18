import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

class Validators {
  final convertionDate = StreamTransformer<DateTime, String>.fromHandlers(
    handleData: (date, sink) {
      sink.add(DateFormat('yyyy-MM-dd').format(date));
    },
  );
}
