import 'package:feedme/services/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Details> _business = fetchBusinessDetails(id);
    return FutureBuilder<Details>(
        future: _business,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text("${snapshot.data.name}"),
              ),
              body: Column(
                children: <Widget>[
                  Center(
                    heightFactor: 5,
                    child: Text("Address: ${snapshot.data.address.address}"),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(50.0),
                      children:
                          List.generate(snapshot.data.photos.length, (index) {
                        return Image(
                          image: NetworkImage(snapshot.data.photos[index]),
                        );
                      }),
                    ),
                  ),
                ],
              ),
//              body: Padding(
//                padding: const EdgeInsets.all(50.0),
//                child: ListView(
//                  children: List.generate(snapshot.data.photos.length, (index) {
//                    return Image(
//                      image: NetworkImage(snapshot.data.photos[index]),
//                    );
//                  }),
//                ),
//              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          // default show a loading spinner
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
