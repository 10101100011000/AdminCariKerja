part of 'pages.dart';

class ReciptPage extends StatefulWidget {
  ReciptPage({Key key}) : super(key: key);

  @override
  _ReciptPageState createState() => _ReciptPageState();
}

class _ReciptPageState extends State<ReciptPage> {
  CollectionReference adsCollection =
      FirebaseFirestore.instance.collection("adss");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
        backgroundColor: Color(0xFFEEA20F),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
                stream: adsCollection.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Failed to get ads info!");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitFadingCircle(
                      size: 50,
                      color: Colors.cyan,
                    );
                  }
                  return ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot doc) {
                      return AdsCard(
                        ads: Ads(
                            doc.data()['id'],
                            doc.data()['name'],
                            doc.data()['description'],
                            doc.data()['link'],
                            doc.data()['image']),
                      );
                    }).toList(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
