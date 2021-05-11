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
  var ctrlId = TextEditingController();
  var hlcode = TextEditingController();

  bool isLoading = false;

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
          Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    child: Container(
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 85,
                                height: 85,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: () async {
                                    ctrlId = TextEditingController(
                                        text: widget.recipt.id);
                                    if (hlcode == "") {
                                      Fluttertoast.showToast(
                                        msg: "Please fill all fields!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      Recipt product = Recipt(ctrlId.text, '',
                                          '', '', hlcode.text, '');
                                      bool result = await HighlightServices
                                          .highlightJobList(product);
                                      if (result == true) {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Highlight request has been sent",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "Failed! Try again",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  },
                                  child: Text('Highlight',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'saira',
                                          fontSize: 15)),
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
