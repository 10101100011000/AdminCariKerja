part of 'pages.dart';

class EditPage extends StatefulWidget {
  EditPage({this.product});
  final Products product;

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController controllerName;
  TextEditingController controllerPrice;

  var ctrlName = TextEditingController();
  var ctrlPrice = TextEditingController();
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
                    TextFormField(
                      controller: ctrlName =
                          TextEditingController(text: widget.product.name),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.edit),
                        labelText: 'Product Name',
                        hintText: 'Write your new product name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ctrlPrice =
                          TextEditingController(text: widget.product.price),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        labelText: 'Price',
                        hintText: "Write new product's price",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        child: Image.network(
                      widget.product.image,
                      scale: 4,
                    )),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          color: Colors.yellow[400],
                          textColor: Colors.black,
                          padding: EdgeInsets.all(15),
                          child: Text("Update Product"),
                          onPressed: () async {
                            ctrlId =
                                TextEditingController(text: widget.product.id);
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
                              Products product = Products(ctrlId.text,
                                  ctrlName.text, ctrlPrice.text, "");
                              bool result =
                                  await ProductServices.editProduct(product);
                              if (result == true) {
                                Fluttertoast.showToast(
                                  msg: "Add product succesful!",
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
                          child: Text("Delete Product"),
                          onPressed: () {
                            ctrlId =
                                TextEditingController(text: widget.product.id);
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
                                          Products product =
                                              Products(ctrlId.text, "", "", "");
                                          bool result = await ProductServices
                                              .deleteProduct(product);
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
