import 'package:creatro_app/UI/List/add_kluiflist_item.dart';
import 'package:creatro_app/UI/List/add_kotslist_item.dart';
import 'package:creatro_app/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool loading = false;
  int index = 0;
  String admin = "Yp4yWGa9bFT4qoF91FTjKb5J2wR2";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
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
            children: [
              Image.asset(
                'assets/icons/LogoCreatro.jpg',
                height: 35,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              curentUser == admin
                  ? IconButton(
                      icon: const Icon(Icons.add),
                      color: const Color(0xffE02087),
                      onPressed: () {
                        // show create postmenu
                        bottomAddMenu(context);
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      body: loading
          ? const Loading()
          : Column(
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
                            backgroundColor: index == 0
                                ? const Color(0xffE02087)
                                : Colors.black,
                            padding: const EdgeInsets.only(
                                top: 0, right: 25, left: 25, bottom: 0)),
                        child: const Text(
                          "Kiss list",
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
                            backgroundColor: index == 1
                                ? const Color(0xffE02087)
                                : Colors.black,
                            padding: const EdgeInsets.only(
                                top: 0, right: 25, left: 25, bottom: 0)),
                        child: const Text(
                          "Puke list",
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
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: loading
                            ? const Loading()
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: FutureBuilder(
                                  future:
                                      firestore.collection('kluiflijst').get(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                      return const Center(child: Loading());
                                    }
                                    return ListView.builder(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      itemCount: (snapshot.data! as dynamic)
                                          .docs
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color:
                                                        const Color(0xffe07034),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  (snapshot.data! as dynamic)
                                                      .docs[index]['item'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: loading
                            ? const Loading()
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: FutureBuilder(
                                  future:
                                      firestore.collection('kotslijst').get(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                      return const Center(child: Loading());
                                    }
                                    return ListView.builder(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      itemCount: (snapshot.data! as dynamic)
                                          .docs
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color:
                                                        const Color(0xffe07034),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  (snapshot.data! as dynamic)
                                                      .docs[index]['item'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                      ),
              ],
            ),
    );
  }

  void bottomAddMenu(context) async {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Add',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Kluif',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.white,
                ),
                onTap: () {
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddKluifListItem()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Kots',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.white,
                ),
                onTap: () {
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddKotsListItem()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
