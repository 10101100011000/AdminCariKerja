part of 'services.dart';

class HighlightServices {
  //setup cloud firestore
  static CollectionReference highCollection = FirebaseFirestore.instance
      .collection("joblist")
      .where('highlight', isEqualTo: "1");
  static DocumentReference highDoc;

  //setup firestore storage
  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;
}
