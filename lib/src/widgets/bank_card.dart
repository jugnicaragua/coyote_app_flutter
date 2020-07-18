import 'package:coyote_app/src/bloc/date_selector.dart';
import 'package:coyote_app/src/bloc/provider.dart';
import 'package:coyote_app/src/models/banks.dart';
import 'package:coyote_app/src/providers/bank_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BankCard extends StatelessWidget {
  ProviderBloc provider;
  final ScrollController scrollController;

  BankCard(this.scrollController);

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderBloc>(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: _getBanks(provider.dateBloc),
      ),
    );
  }

  Widget _getBanks(DateBloc dateBloc) {
    return FutureBuilder(
      future: provider.bankBloc.loadBanks(dateBloc.date),
      builder: (context, AsyncSnapshot<List<Bank>> snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return _setContainerList(snapshot.data[index], index);
            },
            controller: scrollController,
            scrollDirection: Axis.vertical,
          );
        } else {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                  child: _setContainerList(
                    new Bank(
                      bank: '',
                      bestBuyPrice: true,
                      bestSellPrice: true,
                      buy: 0.0,
                      sell: 0.0,
                    ),
                    0,
                  ),
                  baseColor: Colors.blueGrey,
                  highlightColor: Colors.lightBlue[100]);
            },
          );
        }
      },
    );
  }

  Widget _setContainerList(Bank data, position) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 85.0,
              child: Neumorphic(
                padding: EdgeInsets.all(7.0),
                style: NeumorphicStyle(
                  color: Colors.white,
                  depth: 4,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(10.0),
                  ),
                ),
                child: SvgPicture.asset(
                  data.getBankSvg(),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  placeholderBuilder: (context) => Image.asset(
                    'assets/images/jug_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _setHeaders(position),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _setPrices(data),
                ),
              ],
            ),
          ),
          Divider(
            color: Color.fromRGBO(231, 231, 231, 1.0),
          ),
        ],
      ),
    );
  }

  List<Widget> _setHeaders(int position) {
    if (position != 0) {
      return [];
    } else {
      return [
        Text(
          'buy',
          style: TextStyle(color: Colors.black),
        ).tr(),
        Text(
          'sell',
          style: TextStyle(
            color: Colors.black,
          ),
        ).tr()
      ];
    }
  }

  List<Widget> _setPrices(Bank data) {
    final _bestBuyStyle = (data.bestBuyPrice)
        ? TextStyle(
            color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
        : TextStyle(color: Colors.black, fontSize: 20.0);

    final _bestSellStyle = (data.bestSellPrice)
        ? TextStyle(
            color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
        : TextStyle(color: Colors.black, fontSize: 20.0);
    return [
      Text('C\$ ${data.buy}', style: _bestBuyStyle),
      Text('C\$ ${data.sell}', style: _bestSellStyle)
    ];
  }
}
