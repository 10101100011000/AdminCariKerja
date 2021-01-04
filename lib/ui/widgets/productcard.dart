import 'package:bloc_practice/models/models.dart';
import 'package:bloc_practice/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditPage(
                    product: product,
                  )));
        },
        title: Text(
          product.ads ?? '',
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(product.description ?? ''),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(product.image ?? '', scale: 40),
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_red_eye, color: Colors.grey),
          onPressed: () {},
        ),
      ),
    );
  }
}
//     return Card(
//         shape: RoundedRectangleBorder(
//             side: BorderSide(width: 2, color: Colors.black)),
//         color: Colors.yellow,
//         child: ListTile(
//           contentPadding: EdgeInsets.all(10),
//           onTap: () {},
//           title: Text(product.ads,
//               style: TextStyle(fontSize: 18, fontFamily: 'saira')),
//           subtitle: Text(
//             "Gaji : " +
//                 NumberFormat.currency(
//                         locale: 'id', decimalDigits: 0, symbol: 'Rp')
//                     .format(int.parse(product.ads)),
//             style: TextStyle(fontFamily: 'saira', fontSize: 15),
//           ),
//           leading: CircleAvatar(
//             backgroundColor: Colors.white,
//             radius: 25,
//             backgroundImage: NetworkImage(
//               product.image,
//               scale: 40,
//             ),
//           ),
//         ));
//   }
// }
