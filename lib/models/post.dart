import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String postid;
  final postdate;
  final String posturl;
  final String date;

  const Post({
    required this.uid,
    required this.postid,
    required this.postdate,
    required this.posturl,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'postid': postid,
        'postdate': postdate,
        'posturl': posturl,
        'date': date,
      };

  static Post fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      uid: snapshot['uid'],
      postid: snapshot['postid'],
      postdate: snapshot['postdate'],
      posturl: snapshot['posturl'],
      date: snapshot['date'],
    );
  }
}
