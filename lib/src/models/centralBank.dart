import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

CentralBank centralBankFromJson(String str) =>
    CentralBank.fromJson(json.decode(str));

String centralBankToJson(CentralBank data) => json.encode(data.toJson());

class CentralBank {
  CentralBank({
    this.date,
    this.amount,
    this.currency,
    this.id,
    this.updatedOn,
    this.createdOn,
  });

  DateTime date;
  double amount;
  String currency;
  int id;
  dynamic updatedOn;
  String createdOn;

  factory CentralBank.fromJson(Map<String, dynamic> json) => CentralBank(
        date: DateTime.parse(json["date"]),
        amount: json["amount"].toDouble(),
        currency: json["currency"],
        id: json["id"],
        updatedOn: json["updatedOn"],
        createdOn:
            DateFormat('yyyy-MM-dd').format(DateTime.parse(json["createdOn"])),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "currency": currency,
        "id": id,
        "updatedOn": updatedOn,
        "createdOn": createdOn,
      };
}
