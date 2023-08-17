import 'package:creatro_app/loading.dart';
import 'package:creatro_app/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool loading = false;
  int index = 0;
  String admin = "Yp4yWGa9bFT4qoF91FTjKb5J2wR2";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String curentUser = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/LogoCreatro.jpg',
                height: 35,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  // show listview of items on list
                  await AuthenticationService().signOut();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    backgroundColor: const Color(0xffe07034),
                    padding: const EdgeInsets.only(
                        top: 0, right: 20, left: 20, bottom: 0)),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // show listview of items on list
                    setState(() {
                      index = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      backgroundColor:
                          index == 0 ? const Color(0xffE02087) : Colors.black,
                      padding: const EdgeInsets.only(
                          top: 0, right: 25, left: 25, bottom: 0)),
                  child: const Text(
                    "Contact",
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // show listview of items on list
                    setState(() {
                      index = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      backgroundColor:
                          index == 1 ? const Color(0xffE02087) : Colors.black,
                      padding: const EdgeInsets.only(
                          top: 0, right: 25, left: 25, bottom: 0)),
                  child: const Text(
                    "Important",
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          index == 0
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      "The introduction week of Creative Business and International is about to begin!. Come along and get to know Inholland, your fellow students and Haarlem as a city! \n\nBijdorplaan 15 \n2015 CE Haarlem \ninfo@creatro.nl",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      "During the introduction week we keep our environment clean. Always keep an eye on each other to keep it safe and fun for everyone.\n\nNo alcohol under 18!",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
