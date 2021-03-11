import 'package:closet/data/bloc.dart';
import 'package:flutter/material.dart';
import 'package:closet/closet.dart';

class tabCategoryPage extends StatefulWidget {
  @override
  _tabCategoryPageState createState() => _tabCategoryPageState();
}

class _tabCategoryPageState extends State<tabCategoryPage> {
  final List<String> _suggestions = <String>[
    '아우터',
    '상의',
    '하의',
    '신발',
    '악세사리',
    '원피스',
    '가방',
    '모자',
    '양말'
  ];
  final Set<String> _selectedCategory = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.of(context).pop(
                MaterialPageRoute(
                    builder: (context) => closet()));
          }
        ),
        title: Text('카테고리 편집'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<String>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          return ListView.builder(itemBuilder: (context, index) {
            return Column(
              children: [
                _buildRow(snapshot.data, _suggestions[index]),
                Divider(),
              ],
            );
            if (index.isOdd) {
              return Divider();
            }

            var realIndex = index ~/ 2;

            return _buildRow(snapshot.data, _suggestions[realIndex]);
          });
        }
    );
  }

  Widget _buildRow(Set<String> saved, String data) {
    final bool alreadySaved = saved.contains(data);

    return Row(
      children: <Widget>[
        IconButton(
            icon: alreadySaved ? Icon(Icons.remove_circle)
              : Icon(Icons.add_circle),
            color: alreadySaved ? Colors.red : Colors.green,
            onPressed: bloc.addToOrRemoveFromSavedList(data)),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
            ),
            child: Text(data))
      ],
    );

    //   ListTile(
    //   title: Text(
    //     '$data',
    //     textScaleFactor: 1.5,
    //   ),
    //   trailing: Icon(
    //     alreadySaved? Icons.favorite : Icons.favorite_border,
    //     color: Colors.pink,
    //   ),
    //   onTap: () {
    //     bloc.addToOrRemoveFromSavedList(data);
    //   },
    // );
  }
}
