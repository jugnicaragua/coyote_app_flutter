import 'package:coyote_app/src/bloc/bank_bloc.dart';
import 'package:coyote_app/src/bloc/central_bank_bloc.dart';
import 'package:coyote_app/src/bloc/date_selector.dart';
import 'package:flutter/material.dart';

class ProviderBloc extends InheritedWidget {
  final dateBloc = DateBloc();
  final centralBankBloc = CentralBankBloc();
  final bankBloc = BankBloc();
  static ProviderBloc _instancia;

  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._(key: key, child: child);
    }
    return _instancia;
  }

  ProviderBloc._({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DateBloc ofDate(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .dateBloc;
  }

  static BankBloc ofBank(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .bankBloc;
  }

  static CentralBankBloc ofCentralBank(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .centralBankBloc;
  }
}
