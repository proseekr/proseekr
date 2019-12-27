import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProviderFeed extends StatelessWidget {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document["FavJobs"]['title']),
      subtitle: Text(document["FavJobs"]['category']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StreamBuilder with FireStore")),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Fav').snapshots(),
        //print an integer every 2secs, 10 times
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading..");
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return _buildList(context, snapshot.data.documents[index]);
            },
          );
        },
      ),
    );
  }
}
