import 'package:creatro_app/loading.dart';
import 'package:creatro_app/mobilescreenlayout.dart';
import 'package:creatro_app/service/authentication_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  bool inputText = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      loading = true;
    });
    String result = await AuthenticationService().logUser(
        email: _emailController.text, password: _passwordController.text);
    if (result == 'success') {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
      );
    } else {
      return;
      // add text next to or with a snackbar of error details!!
      // showAlertCard("Oops!", result, Colors.black, context);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                            Colors.black26, BlendMode.darken),
                        child: Image.asset(
                          'assets/images/image_1.jpg',
                          height: height * 0.63,
                          width: width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.only(top: 50, left: 10),
                            icon: const Icon(
                              Icons.keyboard_arrow_left,
                              color: Color(0xffE02087),
                            ),
                            iconSize: 40,
                            onPressed: () {
                              // navigator.pop returns to the last visited page
                              Navigator.pop(
                                context,
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: height * 0.6),
                          Container(
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffE02087),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        child: TextField(
                                          controller: _emailController,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.normal,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Wachtwoord',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffE02087),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey),
                                        )),
                                        child: TextField(
                                          obscureText: true,
                                          controller: _passwordController,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.normal,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: _emailController
                                                .text.isNotEmpty &&
                                            _passwordController.text.isNotEmpty
                                        ? () async {
                                            loginUser();
                                            // Navigator.of(context).pushReplacement(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const MobileScreenLayout()));
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        backgroundColor:
                                            const Color(0xffE02087),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 110,
                                            left: 110,
                                            bottom: 10)),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
