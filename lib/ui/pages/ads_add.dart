part of 'pages.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final ctrlName = TextEditingController();
  final ctrlDesc = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlDesc.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlDesc.clear();
    setState(() {
      imageFile = null;
    });
  }

  PickedFile imageFile;
  final ImagePicker imagepicker = ImagePicker();
  Future chooseImage() async {
    final selectedImage = await imagepicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        backgroundColor: Color(0xFFEEA20F),
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
                    imageFile == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton.icon(
                                  onPressed: () {
                                    chooseImage();
                                  },
                                  icon: Icon(Icons.image_rounded),
                                  label: Text("Choose from gallery")),
                              Text("Image preview"),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton.icon(
                                  onPressed: () {
                                    chooseImage();
                                  },
                                  icon: Icon(Icons.image_rounded),
                                  label: Text("Re-Choose from gallery")),
                              Semantics(
                                  child: Image.file(
                                File(imageFile.path),
                                width: 100,
                              ))
                            ],
                          ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ctrlName,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add_box_rounded),
                          labelText: 'Ads Name',
                          hintText: "Write your Product Name",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ctrlDesc,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.description_rounded),
                          labelText: 'Description',
                          hintText: "Write the ads description",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 250)),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(20),
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text("Add Product"),
                      onPressed: () async {
                        if (ctrlName.text == "" ||
                            ctrlDesc.text == "" ||
                            imageFile == null) {
                          Fluttertoast.showToast(
                            msg: "Please fill all fields !",
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
                          Products product =
                              Products("", ctrlName.text, ctrlDesc.text, "");
                          bool result = await ProductServices.addProduct(
                              product, imageFile);
                          if (result == true) {
                            Fluttertoast.showToast(
                              msg: "Add Product Successful.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            clearForm();
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: "Failed! Try Again",
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
                    SizedBox(
                      height: 20,
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
                  child: SpinKitFadingCircle(
                    size: 50,
                    color: Colors.cyan,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
