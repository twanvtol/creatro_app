import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String uid;
  final String item;
  final postdate;

  const Item({
    required this.uid,
    required this.item,
    required this.postdate,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'item': item,
        'postdate': postdate,
      };

  static Item fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Item(
      uid: snapshot['uid'],
      item: snapshot["item"],
      postdate: snapshot["postdate"],
    );
  }
}
