import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: const Center(
          child: SpinKitChasingDots(
            color: Color(0xffE02087),
            size: 35,
          ),
        ),
      ),
    );
  }
}
