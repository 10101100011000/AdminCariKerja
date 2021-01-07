import 'package:bloc_practice/models/models.dart';
import 'package:bloc_practice/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdsCard extends StatelessWidget {
  final Ads ads;
  AdsCard({this.ads});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditPage(
                    ads: ads,
                  )));
        },
        title: Text(
          ads.ads ?? '',
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(ads.description ?? ''),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(ads.image ?? '', scale: 40),
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_red_eye, color: Colors.grey),
          onPressed: () {},
        ),
      ),
    );
  }
}
