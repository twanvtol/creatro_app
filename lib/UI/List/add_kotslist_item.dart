import 'package:creatro_app/confirm.dart';
import 'package:creatro_app/mobilescreenlayout.dart';
import 'package:creatro_app/service/post_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddKotsListItem extends StatefulWidget {
  const AddKotsListItem({Key? key}) : super(key: key);

  @override
  _AddKotsListItemState createState() => _AddKotsListItemState();
}

class _AddKotsListItemState extends State<AddKotsListItem> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _item1Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void postKotsItem(String item, String uid) async {
    try {
      await PostService().uploadKotsListItem(uid, item);
    } catch (e) {
      return;
    }
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
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
                      "Add item",
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
            Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 15, left: 30, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent,
              ),
              child: TextField(
                controller: _item1Controller,
                maxLength: 28,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText: "Persoon",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => postKotsItem(_item1Controller.text, uid),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  padding: const EdgeInsets.only(
                      top: 10, right: 125, left: 125, bottom: 10),
                ),
                child: const FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Add",
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
