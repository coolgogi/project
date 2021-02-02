import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class NewEventPage extends StatefulWidget {
  final _selectedDayDay;
  NewEventPage(this._selectedDayDay);
  @override
  _NewEventPageState createState() => _NewEventPageState(_selectedDayDay);
}

class _NewEventPageState extends State<NewEventPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _memo = TextEditingController();
  DateTime _selectedDayDay;

  _NewEventPageState(this._selectedDayDay) {
    _selectedDayDay = this._selectedDayDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: ListView(
          children: [
            Text(_selectedDayDay.toString()),
            _category('일정'),
            _divier(),
            _titileField(),
            _locationField(),
            _category('코디설정'),
            _divier(),
            _category('메모'),
          ],
        )

    );
  }

  Widget _appBar(){
    return AppBar(
      leading: _appbarCancel(),
      title: _appbarTitle(),
      actions: [
        _appbarAdd(),
      ],
    );
  }

  Widget _locationField(){
    return TextField(
      controller: _location,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: '위치',
      ),
    );
  }

  Widget _titileField(){
    return TextField(
      controller: _title,
      // obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: '제목',
      ),
    );
  }

  Widget _divier(){
    return Divider(
      color: Colors.grey,
      height: 10,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }

  Widget _category(String title) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.grey,
              fontSize: 10),),);

  }
  Widget _appbarAdd() {
    return FlatButton(onPressed: () {},
        child: Text('추가',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,),));
  }

  Widget _appbarTitle() {
    return Center(
        child: Text('새로운 이벤트',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,),));
  }

  Widget _appbarCancel() {
    return FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('취소',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 15,),));

  }
}