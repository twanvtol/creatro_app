import 'dart:ffi';

import 'package:creatro_app/confirm.dart';
import 'package:creatro_app/loading.dart';
import 'package:creatro_app/service/post_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePostUpload extends StatefulWidget {
  final Uint8List uploadImage;
  final DateTime? dateTime;
  const CreatePostUpload(
      {required this.uploadImage, required this.dateTime, Key? key})
      : super(key: key);

  @override
  _CreatePostUploadState createState() => _CreatePostUploadState();
}

class _CreatePostUploadState extends State<CreatePostUpload> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _captionController = TextEditingController();
  String profileimage = "";
  String username = "";
  bool status = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var usersnap =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      setState(() {
        username = usersnap.data()!['username'];
      });
    } catch (e) {}
  }

  void postData(String username, String uid) async {
    setState(() {
      status = true;
    });
    try {
      await PostService()
          .uploadPostData(username, uid, widget.uploadImage, widget.dateTime);
    } catch (e) {
      return;
    }
    setState(() {
      status = false;
    });
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConfirmScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left),
                  iconSize: 35,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Almost finished!",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: heigth * 0.35,
            ),
            Center(
              child: status
                  ? const Loading()
                  : ElevatedButton(
                      onPressed: () => postData(username, uid),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200)),
                        padding: const EdgeInsets.only(
                            top: 50, right: 45, left: 45, bottom: 50),
                      ),
                      child: const FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Post!",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
