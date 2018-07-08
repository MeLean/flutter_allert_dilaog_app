import 'package:flutter/material.dart';

class CustomAlertDialog extends AlertDialog {
  final Widget title;
  final EdgeInsetsGeometry titlePadding;
  final Widget content;
  final EdgeInsetsGeometry contentPadding;
  final List<Widget> actions;
  final String semanticLabel;

  CustomAlertDialog(
      {Key key,
      this.title,
      this.titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      this.content,
      this.contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
      this.actions,
      this.semanticLabel})
      : assert(contentPadding != null, titlePadding != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    String label = semanticLabel;

    if (title != null) {
      children.add(new Padding(
        padding: titlePadding ??
            new EdgeInsets.fromLTRB(
                24.0, 24.0, 24.0, content == null ? 20.0 : 0.0),
        child: new DefaultTextStyle(
          style: Theme.of(context).textTheme.title,
          child: new Semantics(child: title, namesRoute: true),
        ),
      ));
    } else {
      switch (Theme.of(context).platform) {
        //add Theme.of(context).platform instead defaultTargetPlatform
        case TargetPlatform.iOS:
          label = semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          label = semanticLabel ??
              MaterialLocalizations.of(context)?.alertDialogLabel;
      }
    }

    if (content != null) {
      children.add(new Flexible(
        child: new Padding(
          padding: contentPadding,
          child: new DefaultTextStyle(
            style: Theme.of(context).textTheme.subhead,
            child: content,
          ),
        ),
      ));
    }

    if (actions != null) {
      children.add(new ButtonTheme.bar(
        child: new ButtonBar(
          alignment: MainAxisAlignment.spaceBetween, //add this line
          children: actions,
        ),
      ));
    }

    Widget dialogChild = new IntrinsicWidth(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );

    if (label != null)
      dialogChild =
          new Semantics(namesRoute: true, label: label, child: dialogChild);

    return new Dialog(child: dialogChild);
  }
}
