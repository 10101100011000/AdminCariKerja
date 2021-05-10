part of 'pages.dart';

class ReceiptPageMy extends StatefulWidget {
  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPageMy> {
  CollectionReference adsCollection =
      FirebaseFirestore.instance.collection("joblist");

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
                stream: FirebaseFirestore.instance
                    .collection("joblist")
                    .where("highlight", isEqualTo: "1")
                    .snapshots(),
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
                      return HighlightCard(
                        recipt: Recipt(
                            doc.data()['id'],
                            doc.data()['judul'],
                            doc.data()['deskripsi'],
                            doc.data()['gaji'],
                            doc.data()['owner'],
                            doc.data()['imageH']),
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
