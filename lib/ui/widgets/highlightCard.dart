import 'package:bloc_practice/models/models.dart';
import 'package:bloc_practice/ui/pages/pages.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class HighlightCard extends StatelessWidget {
  final Recipt recipt;
  HighlightCard({this.recipt});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReciptPage(
                    recipt: recipt,
                  )));
        },
        title: Text(
          recipt.judul ?? '',
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(recipt.owner ?? ''),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(recipt.imageH ?? ''),
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_red_eye, color: Colors.grey),
          onPressed: () {},
        ),
      ),
    );
  }
}
