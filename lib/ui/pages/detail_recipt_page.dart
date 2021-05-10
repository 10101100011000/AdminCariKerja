part of 'pages.dart';

class ReciptPage extends StatefulWidget {
  ReciptPage({this.recipt});
  final Recipt recipt;

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
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 45),
            child: Text(
              widget.recipt.judul,
              style: TextStyle(
                  color: Colors.black, fontFamily: 'saira', fontSize: 25),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.recipt.imageH),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white),
              width: 270,
              height: 270,
            ),
          ),
        ],
      ),
    );
  }
}
