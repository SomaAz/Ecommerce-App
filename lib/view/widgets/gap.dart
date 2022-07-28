import 'package:flutter/cupertino.dart';

class Gap extends StatelessWidget {
  const Gap({Key? key, this.height, this.width}) : super(key: key);
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}

class GapH extends StatelessWidget {
  const GapH(this.height, {Key? key}) : super(key: key);
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Gap(height: height);
  }
}

class GapW extends StatelessWidget {
  const GapW(this.width, {Key? key}) : super(key: key);
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Gap(width: width);
  }
}
