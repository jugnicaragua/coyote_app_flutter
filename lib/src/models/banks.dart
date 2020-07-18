// To parse this JSON data, do
//
//     final root = rootFromJson(jsonString);

import 'dart:convert';

import 'package:coyote_app/src/utils/svg_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Root rootFromJson(String str) => Root.fromJson(json.decode(str));

String rootToJson(Root data) => json.encode(data.toJson());

class Root {
  Root({
    this.size,
    this.data,
  });

  int size;
  List<Bank> data;

  factory Root.fromJson(Map<String, dynamic> json) => Root(
        size: json["size"],
        data: List<Bank>.from(json["data"].map((x) => Bank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Bank {
  Bank({
    this.date,
    this.bestSellPrice,
    this.bank,
    this.sell,
    this.buy,
    this.currency,
    this.id,
    this.updatedOn,
    this.createdOn,
    this.bestBuyPrice,
  });

  DateTime date;
  bool bestSellPrice;
  String bank;
  double sell;
  double buy;
  String currency;
  int id;
  dynamic updatedOn;
  String createdOn;
  bool bestBuyPrice;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        date: DateTime.parse(json["date"]),
        bestSellPrice: json["bestSellPrice"],
        bank: json["bank"],
        sell: json["sell"].toDouble(),
        buy: json["buy"].toDouble(),
        currency: json["currency"],
        id: json["id"],
        updatedOn: json["updatedOn"],
        createdOn:
            DateFormat('yyyy-MM-dd').format(DateTime.parse(json["createdOn"])),
        bestBuyPrice: json["bestBuyPrice"],
      );

  factory Bank.fromDb(Map<String, dynamic> jsonDb) => Bank(
        date: DateTime.parse(jsonDb["date"]),
        bestSellPrice: jsonDb["bestSellPrice"] == 1,
        bank: jsonDb["bank"],
        sell: jsonDb["sell"].toDouble(),
        buy: jsonDb["buy"].toDouble(),
        currency: jsonDb["currency"],
        id: jsonDb["id"],
        updatedOn: jsonDb["updatedOn"],
        createdOn: DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(jsonDb["createdOn"])),
        bestBuyPrice: jsonDb["bestBuyPrice"] == 1,
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "bestSellPrice": bestSellPrice ? 1 : 0,
        "bank": bank,
        "sell": sell,
        "buy": buy,
        "currency": currency,
        "id": id,
        "updatedOn": updatedOn,
        "createdOn": createdOn,
        "bestBuyPrice": bestBuyPrice ? 1 : 0,
      };

  String getBankSvg() {
    switch (this.bank) {
      case 'LAFISE':
        return 'assets/images/lafise.svg';
        break;
      case 'BANPRO':
        return 'assets/images/banpro.svg';
        break;
      case 'BAC':
        return 'assets/images/bac.svg';
        break;
      case 'BDF':
        return 'assets/images/bdf.svg';
        break;
      case 'FICOHSA':
        return 'assets/images/ficohsa.svg';
        break;
      case 'AVANZ':
        return 'assets/images/logo-avanz.svg';
        break;
      default:
        return 'assets/images/jug_logo.svg';
    }
  }

  IconData getBankIcon() {
    switch (this.bank) {
      case 'LAFISE':
        return Icons.accessibility_new;
        break;
      case 'BANPRO':
        return SvgIcons.banpro;
        break;
      case 'BAC':
        return SvgIcons.bac;
        break;
      case 'BDF':
        return SvgIcons.bdf;
        break;
      case 'FICOHSA':
        return SvgIcons.fichosa;
        break;
      case 'AVANZ':
        return SvgIcons.logo_avanz;
        break;
      default:
        return Icons.not_interested;
    }
  }
}
