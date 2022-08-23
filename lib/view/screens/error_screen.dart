import 'package:ecommerce_getx/view/widgets/centered_text.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomCenteredText("Error Happend Reload"),
    );
  }
}
