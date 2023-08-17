import 'dart:typed_data';
import 'package:creatro_app/models/item.dart';
import 'package:creatro_app/models/post.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get post data, not used and not working properly
  Future<Post> getCurrentPostData() async {
    User user = _auth.currentUser!;
    DocumentSnapshot snapshot = (await _firestore
        .collection('posts')
        .where('uid', isEqualTo: user)
        .get()) as DocumentSnapshot<Object?>;
    return Post.fromSnapshot(snapshot);
  }

  // upload post data
  Future<String> uploadPostData(
    String username,
    String uid,
    Uint8List file,
    DateTime? date,
  ) async {
    String result = "error";
    String postid = const Uuid().v1();
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-M-dd');
    String formattedDate = formatter.format(now);
    try {
      String postUrl = await uploadImageToStorage('posts', file, true);
      Post post = Post(
        uid: uid,
        postdate: DateTime.now(),
        posturl: postUrl,
        postid: postid,
        date: formattedDate,
      );
      _firestore.collection('posts').doc(postid).set(post.toJson());
      result = "upload success";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // add images to firebasestorage
  Future<String> uploadImageToStorage(
      String childname, Uint8List imfile, bool isposted) async {
    Reference ref =
        _firebaseStorage.ref().child(childname).child(_auth.currentUser!.uid);

    if (isposted) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask task =
        ref.putData(imfile, SettableMetadata(contentType: "image/jpeg"));

    TaskSnapshot snapshot = await task;
    String imageurl = await snapshot.ref.getDownloadURL();
    return imageurl;
  }

  // posts item to kluiflist
  Future<String> uploadKluifListItem(String uid, String listitem) async {
    String result = "error";
    String itemid = const Uuid().v1();
    try {
      Item item = Item(
        uid: uid,
        item: listitem,
        postdate: DateTime.now(),
      );
      _firestore.collection('kluiflijst').doc(itemid).set(item.toJson());
      result = "upload success";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // posts item to kluiflist
  Future<String> uploadKotsListItem(String uid, String persoon) async {
    String result = "error";
    String itemid = const Uuid().v1();
    try {
      Item item = Item(
        uid: uid,
        item: persoon,
        postdate: DateTime.now(),
      );
      _firestore.collection('kotslijst').doc(itemid).set(item.toJson());
      result = "upload success";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
}
