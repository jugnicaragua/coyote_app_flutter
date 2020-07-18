import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChipsWidget extends StatefulWidget {
  final List chipName;
  ChipsWidget({Key key, this.chipName}) : super(key: key);

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChipsWidget> {
  String _isSelected = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.chipName.forEach((item) {
      choices.add(Container(
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(color: Colors.white),
          selectedColor: Color.fromRGBO(15, 125, 197, 1.0),
          backgroundColor: Color.fromRGBO(194, 194, 194, 1.0),
          selected: _isSelected == item,
          onSelected: (selected) {
            setState(() {
              _isSelected = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        direction: Axis.horizontal,
        children: _buildChoiceList(),
      ),
    );
  }
}
