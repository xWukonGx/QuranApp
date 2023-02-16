import 'package:flutter/material.dart';

InputDecoration Input(
  color,
  text,
  hinttext,
) {
  return InputDecoration(
      labelText: text,
      floatingLabelAlignment: FloatingLabelAlignment.center,
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      filled: true,
      hintStyle: TextStyle(color: Colors.black54),
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2.0, color: color)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)));
}

Container SimpleButton(color, text, func) {
  return Container(
    width: 100,
    child: MaterialButton(
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)),
      color: color,
      onPressed: func,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
        ),
      ),
    ),
  );
}

Container OutlinedSimpleButton(color, text, func) {
  return Container(
    width: 100,
    child: MaterialButton(
      shape: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20)),
      onPressed: func,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    ),
  );
}
