import 'package:feedme/details_screen.dart';
import 'package:feedme/services/business.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
// Future variable
  Future<List<Business>> _futureData;

  @override
  void initState() {
    super.initState();
    // hit API and assign value ONCE when widget is added to the tree
    _futureData = fetchBusinessList();
  }

// render the future to the screen via FutureBuilder
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Business>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(id: snapshot.data[index].id)),
                          );
                        },
                        child: Container(
                          height: 120.0,
                          width: 120.0,
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                              image: new NetworkImage(
                                  "${snapshot.data[index].imageUrl}"),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Card(
                        child: Text('${snapshot.data[index].name}'),
                      ),
                    ],
                  );
                });
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
