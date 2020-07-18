import 'package:coyote_app/src/models/centralBank.dart';
import 'package:coyote_app/src/providers/centralBank_provider.dart';
import 'package:coyote_app/src/providers/db_provider.dart';
import 'package:coyote_app/src/utils/network.dart';
import 'package:rxdart/rxdart.dart';

class CentralBankBloc {
  final _centralBankController = new BehaviorSubject<CentralBank>();
  final _loadingController = new BehaviorSubject<bool>();

  final _centralBankProvider = new CentralBankProvider();

  Stream<CentralBank> get banksStream => _centralBankController.stream;
  Stream<bool> get loading => _loadingController.stream;

  Future<CentralBank> loadCentralBankExchangeBy(String date) async {
    final hasConnection = await ConnectionHelper.hasConnection();
    if (hasConnection) {
      final networkBank = await _centralBankProvider.exchangeByDate(date);
      if (networkBank != null)
        await DbProvider.db.insertCentralBank('CentralBank', networkBank);
      return networkBank;
    }
    return await DbProvider.db.centralBankSelectByDate(date);
  }

  dispose() {
    _centralBankController?.close();
    _loadingController?.close();
  }
}
