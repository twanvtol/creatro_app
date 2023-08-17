import 'dart:async';
import 'package:creatro_app/UI/Post/create_post_concept.dart';
import 'package:creatro_app/loading.dart';
import 'package:creatro_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  formatDayTommorow() {
    var item = DateTime.now();
    var format = "${item.year}-${item.month}-${item.day - 1}";
    return format;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            children: [
              Image.asset(
                'assets/icons/LogoCreatro.jpg',
                height: 35,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add),
                color: const Color(0xffE02087),
                onPressed: () {
                  // show create postmenu
                  bottomAddMenu(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: loading
          ? const Loading()
          : Padding(
              padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("posts")
                    .where("date", isEqualTo: formatDayTommorow())
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Loading());
                  }
                  return PageView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    controller:
                        PageController(initialPage: 0, viewportFraction: 1),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Stack(
                            children: [
                              Image.network(
                                (snapshot.data! as dynamic).docs[index]
                                    ['posturl'],
                                fit: BoxFit.cover,
                                height: height,
                                width: width,
                              ),
                              Column(
                                children: [
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            spreadRadius: 20,
                                            blurRadius: 15,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        formatDayTommorow(),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }

  void bottomAddMenu(context) async {
    List<CameraDescription> cameras = await availableCameras();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePostConcept(
          cameras: cameras,
        ),
      ),
    );
  }
}
