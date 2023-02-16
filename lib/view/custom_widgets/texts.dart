import 'package:flutter/cupertino.dart';

title(text, alignment, color) {
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontFamily: 'Tajwal',
        fontSize: 18,
        fontWeight: FontWeight.w700),
    textAlign: alignment,
  );
}

title_2(text, alignment, color) {
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontFamily: 'Tajwal',
        fontSize: 20,
        fontWeight: FontWeight.w700),
    textAlign: alignment,
  );
}

subtitle(text, color, alignment) {
  return Text(
    text,
    textAlign: alignment,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontFamily: 'Cairo',
    ),
  );
}
