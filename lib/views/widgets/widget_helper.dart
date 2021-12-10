import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Flushbar showErrorToast(BuildContext context,
    {String? title, required String message, Duration? duration}) {
  return Flushbar(
    title: title ?? 'Erro',
    message: message,
    icon: Icon(
      Icons.error,
      size: 28.0,
      color: Colors.white,
    ),
    duration: duration ?? Duration(seconds: 4),
    backgroundGradient: LinearGradient(
      colors: [Colors.red[600]!, Colors.red[400]!],
    ),
    onTap: (flushbar) => flushbar.dismiss(),
  )..show(context);
}

class Headline extends StatelessWidget {
  final String title;
  final Color color;
  final bool usePrimaryColor;
  final EdgeInsets padding;
  final int size;

  @override
  Headline(this.title,
      {this.color = Colors.white,
      this.usePrimaryColor = false,
      this.padding = EdgeInsets.zero,
      this.size = 6});

  Widget build(BuildContext context) {
    Color color;
    TextStyle headline;

    this.usePrimaryColor
        ? color = Theme.of(context).primaryColor
        : color = this.color;
    switch (size) {
      case 1:
        headline = Theme.of(context).textTheme.headline1!;
        break;
      case 2:
        headline = Theme.of(context).textTheme.headline2!;
        break;
      case 3:
        headline = Theme.of(context).textTheme.headline3!;
        break;
      case 4:
        headline = Theme.of(context).textTheme.headline4!;
        break;
      case 5:
        headline = Theme.of(context).textTheme.headline5!;
        break;
      case 6:
        headline = Theme.of(context).textTheme.headline6!;
        break;
      default:
        headline = Theme.of(context).textTheme.headline6!;
    }
    TextStyle style = headline.copyWith(color: color);
    return Padding(
      padding: padding,
      child: Text(title, style: style),
    );
  }
}

class SubHeadline extends StatelessWidget {
  final String title;
  final Color color;
  final bool usePrimaryColor;
  final EdgeInsets padding;
  final int size;
  @override
  SubHeadline(this.title,
      {this.color = Colors.white,
      this.usePrimaryColor = false,
      this.padding = EdgeInsets.zero,
      this.size = 1});

  Widget build(BuildContext context) {
    Color color;
    TextStyle subtitle = Theme.of(context).textTheme.subtitle1!;

    this.usePrimaryColor
        ? color = Theme.of(context).primaryColor
        : color = this.color;
    if (size == 2) subtitle = Theme.of(context).textTheme.subtitle2!;
    TextStyle style = subtitle.copyWith(color: color);
    return Padding(
      padding: padding,
      child: Text(title, style: style),
    );
  }
}
