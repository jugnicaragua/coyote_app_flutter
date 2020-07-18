import 'package:coyote_app/src/widgets/bank_card.dart';
import 'package:coyote_app/src/widgets/chips_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:easy_localization/easy_localization.dart';

class SliderIn extends StatelessWidget {
  final ScrollController scrollController;
  SliderIn(this.scrollController);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        color: Colors.white,
        depth: 4,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Container(
              height: 10.0,
              width: 90.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(231, 231, 231, 1.0),
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
            ),
          ),
          ChipsWidget(
            chipName: ['today'.tr(), 'week'.tr(), 'month'.tr()],
          ),
          BankCard(scrollController),
        ],
      ),
    );
  }
}
