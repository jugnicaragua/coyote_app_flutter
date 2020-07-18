import 'package:coyote_app/src/bloc/provider.dart';
import 'package:coyote_app/src/models/centralBank.dart';
import 'package:coyote_app/src/providers/bank_provider.dart';
import 'package:coyote_app/src/providers/centralBank_provider.dart';
import 'package:coyote_app/src/widgets/dashboard_appbar.dart';
import 'package:coyote_app/src/widgets/slider_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ProviderBloc provider;

  DateTime _date = DateTime.now();

  changeDate(bool isAdded) {
    switch (isAdded) {
      case true:
        _date = _date.add(Duration(days: 1));
        provider.dateBloc.changeDate(_date);
        setState(() {});
        break;
      case false:
        _date = _date.subtract(Duration(days: 1));
        provider.dateBloc.changeDate(_date);
        setState(() {});
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderBloc>(context);
    provider.dateBloc.changeDate(_date);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: NeumorphicTheme.currentTheme(context).baseColor,
      appBar: DashboardAppbar(),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity == 0) return;
          (details.primaryVelocity.compareTo(0) == -1)
              ? changeDate(true)
              : changeDate(false);
        },
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return IconButton(
                            icon: NeumorphicIcon(
                              Icons.keyboard_arrow_left,
                              size: (size.width * 0.3),
                              style: NeumorphicStyle(
                                color: Colors.white,
                                depth: 10,
                                intensity: 0.8,
                                shadowDarkColor: Colors.white12,
                              ),
                            ),
                            onPressed: () {
                              changeDate(false);
                            });
                        break;
                      case 1:
                        return Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            StreamBuilder(
                              stream: provider.dateBloc.dateStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return Container(
                                  child: Text(
                                    '${snapshot.data}',
                                    style: TextStyle(
                                      fontSize: (size.width * 0.05),
                                      letterSpacing: 0.3,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: (size.height * 0.010),
                            ),
                            FutureBuilder(
                              future: provider.centralBankBloc
                                  .loadCentralBankExchangeBy(
                                      provider.dateBloc.date),
                              builder: (context,
                                  AsyncSnapshot<CentralBank> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    'C\$ ${snapshot.data.amount}',
                                    style: TextStyle(
                                      fontSize: (size.width * 0.07),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  );
                                } else {
                                  return Shimmer.fromColors(
                                      child: Text(
                                        'C\$ 0.00',
                                        style: TextStyle(
                                          fontSize: (size.width * 0.07),
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      baseColor: Colors.blueGrey,
                                      highlightColor: Colors.lightBlue[100]);
                                }
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 55.0),
                              child: Text(
                                'official',
                                style: TextStyle(
                                  fontSize: (size.width * 0.04),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1.0,
                                ),
                              ).tr(),
                            ),
                          ],
                        );
                        break;
                      case 2:
                        return IconButton(
                            icon: NeumorphicIcon(
                              Icons.keyboard_arrow_right,
                              size: (size.width * 0.3),
                              style: NeumorphicStyle(
                                color: Colors.white,
                                depth: 10,
                                intensity: 0.8,
                                shadowDarkColor: Colors.white12,
                              ),
                            ),
                            onPressed: () {
                              changeDate(true);
                            });
                        break;
                      default:
                        return Container();
                    }
                  },
                ),
              ),
              DraggableScrollableSheet(
                builder: (context, scrollController) {
                  return SliderIn(scrollController);
                },
                initialChildSize: 0.70,
                maxChildSize: 0.70,
                minChildSize: 0.20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
