import 'package:creatro_app/loading.dart';
import 'package:creatro_app/mobilescreenlayout.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return loading
        ? const Loading()
        : Stack(children: [
            ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Colors.black12, BlendMode.darken),
              child: Image.asset(
                'assets/images/image_2.jpg',
                height: height,
                width: width,
                fit: BoxFit.cover,
              ), // video background error FIXX!
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: SizedBox(
                      width: 350,
                      height: 65,
                      child: Image.asset('assets/icons/Creatro-trans.png'),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signInAnonymously();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffE02087),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.only(
                            top: 15, right: 140, left: 140, bottom: 15)),
                    child: const Text(
                      "Student",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.only(
                            top: 15, right: 110, left: 110, bottom: 15)),
                    child: const Text(
                      "Begeleider",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ]);
  }
}
