import 'package:coyote_app/src/bloc/validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/rxdart.dart';

class DateBloc with Validators {
  final _dateController = BehaviorSubject<DateTime>();

  Stream<String> get dateStream =>
      _dateController.stream.transform(convertionDate);

  Function(DateTime) get changeDate => _dateController.sink.add;
  String get date => DateFormat('yyyy-MM-dd').format(_dateController.value);

  dispose() {
    _dateController?.close();
  }
}
