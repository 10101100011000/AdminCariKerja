part of 'services.dart';

class AdsServices {
  //setup cloud firestore
  static CollectionReference adsCollection =
      FirebaseFirestore.instance.collection("adss");
  static DocumentReference adsDoc;

  //setup firestore storage
  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;

  static Future<bool> addads(Ads ads, PickedFile imgFile) async {
    await Firebase.initializeApp();
    adsDoc = await adsCollection.add({
      'id': "",
      'name': ads.ads,
      'description': ads.description,
      'image': "",
    });

    if (adsDoc.id != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(adsDoc.id + ".png");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(() => ref.getDownloadURL().then(
            (value) => imgUrl = value,
          ));

      adsCollection.doc(adsDoc.id).update({
        'id': adsDoc.id,
        'image': imgUrl,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> editads(Ads ads) async {
    await Firebase.initializeApp();

    await adsCollection.doc(ads.id).update(
      {
        'name': ads.ads,
        'description': ads.description,
      },
    );

    return true;
  }

  static Future<bool> deleteads(Ads ads) async {
    await Firebase.initializeApp();

    await adsCollection.doc(ads.id).delete();

    return true;
  }
}
