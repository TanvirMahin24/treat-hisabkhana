import 'package:flutter/material.dart';

Container circularProgress(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 20),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
    ),
  );
}
