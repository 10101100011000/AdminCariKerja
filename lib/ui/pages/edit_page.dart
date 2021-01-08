part of 'pages.dart';

class EditPage extends StatefulWidget {
  EditPage({this.ads});
  final Ads ads;

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerLink;

  var ctrlName = TextEditingController();
  var ctrlPrice = TextEditingController();
  var ctrlLink = TextEditingController();
  var ctrlId = TextEditingController();

  bool isLoading;

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseImage() async {
    final selectedImage = await imagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      imageFile = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                        child: Image.network(
                      widget.ads.image,
                      scale: 4,
                    )),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ctrlName =
                          TextEditingController(text: widget.ads.ads),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.add_box_rounded),
                        labelText: 'Ads Name',
                        hintText: 'Write your new ads name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ctrlPrice = TextEditingController(
                          text: widget.ads.description),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.add_box_rounded),
                        labelText: 'Description',
                        hintText: "Write new the ads description",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ctrlLink = TextEditingController(
                          text: widget.ads.link),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.add_box_rounded),
                        labelText: 'Link',
                        hintText: "Write new the ads link",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 250),
                    // SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          color: Colors.greenAccent,
                          textColor: Colors.black,
                          padding: EdgeInsets.all(15),
                          child: Text("Update Ads"),
                          onPressed: () async {
                            ctrlId =
                                TextEditingController(text: widget.ads.id);
                            if (ctrlName.text == "" || ctrlPrice.text == "") {
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
                              Ads ads = Ads(ctrlId.text,
                                  ctrlName.text, ctrlPrice.text, ctrlLink.text, "");
                              bool result =
                                  await AdsServices.editads(ads);
                              if (result == true) {
                                Fluttertoast.showToast(
                                  msg: "Add ads succesful!",
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
                        ),
                        SizedBox(width: 20),
                        RaisedButton(
                          color: Colors.red[300],
                          textColor: Colors.white,
                          padding: EdgeInsets.all(15),
                          child: Text("Delete Ads"),
                          onPressed: () {
                            ctrlId =
                                TextEditingController(text: widget.ads.id);
                            showDialog(
                                context: context,
                                // ignore: non_constant_identifier_names
                                builder: (BuildContext) {
                                  return AlertDialog(
                                    title: Text("Confirmation"),
                                    content:
                                        Text("Are you sure want to delete?"),
                                    actions: [
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          Ads ads =
                                              Ads(ctrlId.text, "", "", "", "");
                                          bool result = await AdsServices
                                              .deleteads(ads);
                                          if (result == true) {
                                            Fluttertoast.showToast(
                                              msg: "Delete product succesful!",
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
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("no"),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          isLoading == true
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: SpinKitFadingCircle(size: 50, color: Colors.blue),
                )
              : Container(),
        ],
      ),
    );
  }
}
