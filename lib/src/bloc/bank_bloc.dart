import 'package:coyote_app/src/models/banks.dart';
import 'package:coyote_app/src/providers/bank_provider.dart';
import 'package:coyote_app/src/providers/db_provider.dart';
import 'package:coyote_app/src/utils/network.dart';
import 'package:rxdart/rxdart.dart';

class BankBloc {
  final _bankController = new BehaviorSubject<List<Bank>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _bankProvider = new BankProvider();

  Stream<List<Bank>> get banksStream => _bankController.stream;
  Stream<bool> get loading => _loadingController.stream;

  Future<List<Bank>> loadBanks(String date) async {
    final hasConnection = await ConnectionHelper.hasConnection();
    if (hasConnection) {
      final networkBank = await _bankProvider.loadBanks(date);
      if (networkBank != null)
        await DbProvider.db.insertAll('Bank', networkBank.data);
      return networkBank.data;
    }
    return await DbProvider.db.selectByDate(date);
  }

  dispose() {
    _bankController?.close();
    _loadingController?.close();
  }
}
