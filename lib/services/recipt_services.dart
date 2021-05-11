part of 'services.dart';

class HighlightServices {
  //setup cloud firestore
  static CollectionReference highCollection =
      FirebaseFirestore.instance.collection("joblist");
  static DocumentReference highDoc;

  //setup firestore storage
  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;

  static Future<bool> highlightJobList(Recipt joblist) async {
    await Firebase.initializeApp();

    await highCollection.doc(joblist.id).update(
      {'highlight': "0", 'code': joblist.code},
    );

    return true;
  }
}
