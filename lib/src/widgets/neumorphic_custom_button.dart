import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicCustomButton<T> extends StatefulWidget {
  const NeumorphicCustomButton({
    Key key,
    @required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.all(8.0),
    this.child,
    this.icon,
    this.offset = Offset.zero,
    this.enabled = true,
    this.shape,
    this.color,
    this.captureInheritedThemes = true,
  })  : assert(itemBuilder != null),
        assert(offset != null),
        assert(enabled != null),
        assert(captureInheritedThemes != null),
        assert(!(child != null && icon != null),
            'You can only pass [child] or [icon], not both.'),
        super(key: key);
  final PopupMenuItemBuilder<T> itemBuilder;
  final T initialValue;
  final PopupMenuItemSelected<T> onSelected;
  final PopupMenuCanceled onCanceled;
  final String tooltip;
  final double elevation;
  final EdgeInsets padding;
  final Widget child;
  final Widget icon;
  final Offset offset;
  final bool enabled;
  final ShapeBorder shape;
  final Color color;
  final bool captureInheritedThemes;

  @override
  NeumorphicCustomButtonState<T> createState() =>
      NeumorphicCustomButtonState<T>();
}

class NeumorphicCustomButtonState<T> extends State<NeumorphicCustomButton<T>> {
  void showButtonMenu() {
    final popupMenuTheme = PopupMenuTheme.of(context);
    final nTheme = NeumorphicTheme.of(context);
    final button = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(widget.offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final items = widget.itemBuilder(context);
    if (items.isNotEmpty) {
      showMenu<T>(
        context: context,
        elevation: widget.elevation ?? popupMenuTheme.elevation,
        items: items,
        initialValue: widget.initialValue,
        position: position,
        shape: widget.shape ?? popupMenuTheme.shape,
        color: widget.color ?? nTheme.current.baseColor ?? popupMenuTheme.color,
        captureInheritedThemes: widget.captureInheritedThemes,
      ).then<void>((T newValue) {
        if (!mounted) {
          return null;
        }
        if (newValue == null) {
          if (widget.onCanceled != null) {
            widget.onCanceled();
          }
          return null;
        }
        if (widget.onSelected != null) {
          widget.onSelected(newValue);
        }
      });
    }
  }

  Icon _getIcon(TargetPlatform platform) {
    assert(platform != null);
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const Icon(Icons.more_vert);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const Icon(Icons.more_horiz);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));

    if (widget.child != null) {
      return Tooltip(
        message:
            widget.tooltip ?? MaterialLocalizations.of(context).showMenuTooltip,
        child: InkWell(
          onTap: widget.enabled ? showButtonMenu : null,
          canRequestFocus: widget.enabled,
          child: widget.child,
        ),
      );
    }

    return NeumorphicButton(
      child: widget.icon ?? _getIcon(Theme.of(context).platform),
      padding: widget.padding,
      tooltip:
          widget.tooltip ?? MaterialLocalizations.of(context).showMenuTooltip,
      onPressed: widget.enabled ? showButtonMenu : null,
    );
  }
}
