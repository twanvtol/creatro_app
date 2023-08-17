import 'package:cloud_firestore/cloud_firestore.dart';

class CreatroUser {
  final String uid;
  final String email;
  final String photourl;

  const CreatroUser({
    required this.uid,
    required this.email,
    required this.photourl,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'photourl': photourl,
      };

  static CreatroUser fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CreatroUser(
      uid: snapshot['uid'],
      email: snapshot['email'],
      photourl: snapshot["photourl"],
    );
  }
}
