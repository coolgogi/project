import 'package:closet/data/weather.dart';
import 'package:flutter/material.dart';
import '../weatherPage.dart';

class cody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ListView(
      children: <Widget>[
        Container(
          child: SizedBox(
            height: size.height * 0.129,
            child: GestureDetector(
                  onTap: () {Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => weatherPage())
                  );
                },
                child: weatherBar(),
            ),
          ),
        ),
        GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16.0),
                  childAspectRatio: 8.0 / 9.0,
                  children: <Widget>[
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi1.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi2.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi3.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi9.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi5.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi6.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi7.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi8.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi9.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi1.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi2.jpg'),
                      ),
                    ),
                  ]
              ),
      ],
    );
  }
}


class outers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: <Widget>[
          Card(
            child: Stack(
                children: <Widget>[
                  Image.asset('assets/codi1.jpg'),
                  Positioned(right: 2, bottom: 2, child: Icon(Icons.favorite_outline)),
                ]
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi2.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi3.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi9.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi5.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi6.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi7.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi8.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi9.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi1.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi2.jpg'),
            ),
          ),
        ]
    );
  }
}


class tops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 8.0 / 9.0,
      children: <Widget>[
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Stack(
                children: <Widget>[
                  Image.asset('assets/codi1.jpg'),
                  Positioned(right: 2, bottom: 2, child: Icon(Icons.favorite_outline)),
                ]
            ),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi2.jpg'),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi3.jpg'),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi9.jpg'),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi5.jpg'),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi6.jpg'),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi7.jpg'),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi8.jpg'),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi9.jpg'),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi1.jpg'),
          ),
        ),
        Card(
          child: AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/codi2.jpg'),
          ),
        ),
    ]);
  }
}


class pants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: <Widget>[
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Stack(
                  children: <Widget>[
                    Image.asset('assets/codi1.jpg'),
                    Positioned(right: 2, bottom: 2, child: Icon(Icons.favorite_outline)),
                  ]
              ),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi2.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi3.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi9.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi5.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi6.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi7.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi8.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi9.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi1.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi2.jpg'),
            ),
          ),
        ]
    );
  }
}


class shoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: <Widget>[
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Stack(
                  children: <Widget>[
                    Image.asset('assets/codi1.jpg'),
                    Positioned(right: 2, bottom: 2, child: Icon(Icons.favorite_outline)),
                  ]
              ),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi2.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi3.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi9.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi5.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi6.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi7.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi8.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi9.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi1.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi2.jpg'),
            ),
          ),
        ]
    );
  }
}


class accessories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: <Widget>[
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Stack(
                  children: <Widget>[
                    Image.asset('assets/codi1.jpg'),
                    Positioned(right: 2, bottom: 2, child: Icon(Icons.favorite_outline)),
                  ]
              ),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi2.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi3.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi9.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi5.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi6.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi7.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi8.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi9.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi1.jpg'),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('assets/codi2.jpg'),
            ),
          ),
        ]
    );
  }
}