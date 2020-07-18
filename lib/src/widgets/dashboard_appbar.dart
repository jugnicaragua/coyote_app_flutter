import 'package:coyote_app/src/widgets/neumorphic_custom_button.dart';
import 'package:coyote_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicAppBar(
      title: Container(),
      actions: <Widget>[
        NeumorphicCustomButton(
          icon: Icon(
            FontAwesomeIcons.ellipsisV,
            color: Colors.white,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onSelected: (String selected) {},
          itemBuilder: (_) => <PopupMenuItem<String>>[
            PopupMenuItem<String>(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.cog),
                    SizedBox(width: Style.halfPadding),
                    const Text('settings').tr(),
                  ],
                ),
                value: 'Settings'),
            PopupMenuItem<String>(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.userFriends),
                    SizedBox(width: Style.halfPadding),
                    const Text('credits').tr(),
                  ],
                ),
                value: 'credits'),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 16 * 2);
}
