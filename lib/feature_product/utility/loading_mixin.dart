import 'package:flutter/material.dart';

mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
