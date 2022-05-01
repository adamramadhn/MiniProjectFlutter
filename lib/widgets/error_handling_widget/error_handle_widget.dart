import 'package:flutter/material.dart';

class ErrorHandleWidget extends StatelessWidget {
  const ErrorHandleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/img/offlineimage.jpg',
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
