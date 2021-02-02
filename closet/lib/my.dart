import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class My extends StatefulWidget{
  @override
  _MyState createState() =>_MyState();
}

class _MyState extends State<My>{
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),),
      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal:0),
        child:ListView(
          children: <Widget>[
            //imageProfile(),
            ListTile(
              title: Text('NICkNAME님 안녕하세요!'),
              subtitle: Text('NICKNAME@아이디'),
              leading: CircleAvatar(
                backgroundImage:_imageFile == null
                    ?AssetImage('assets/profile.jpg')
                    :FileImage(File(_imageFile.path)),
              ),
            ),
            _divier(),
            ListTile(
              title: Text('회원정보 수정'),
            ),
            ListTile(
              title: Text('관심 스타일 설정'),
            ),
            ListTile(
              title: Text('성별 설정'),
            ),
            ListTile(
              title: Text('로그아웃'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
            ListTile(
              title: Text('회원탈퇴'),
            ),
            _divier(),
            ListTile(
              title: Text('서비스 설정',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey ),),
            ),
            ListTile(
              title: Text('실험실'),
            ),
            ListTile(
              title: Text('설정'),
            ),
            _divier(),
            ListTile(
              title: Text('고객센터',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey ),),
            ),
            ListTile(
              title: Text('공지사항'),
            ),
            ListTile(
              title: Text('앱 문의 건의'),
            ),
            _divier(),
            _info(),

            /*
            //SizedBox(height:20),

           // nameTextField(),
            //SizedBox(height:20),

            ListTile(
              //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
              title: Text('내 정보'),
                //onTap: () { /* react to the tile being tapped */ }
            ),
            ListTile(
              title: Text('서비스 설정'),
            ),
            ListTile(
              title: Text('고객센터'),
            )
             */


          ],

        )
      )
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

  Widget _info(){
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 20),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Text(
                '서비스 이용 약관',
                style: TextStyle(
                    color: Colors.grey,
                fontSize: 10),)),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Text(
                '개인정보 처리방침',
                style: TextStyle(
                  color: Colors.grey,
                fontSize: 10,),)),
        ],
      ),
    );
  }

  Widget imageProfile(){
    return Center(
        child:Stack(
          children: <Widget>[
            CircleAvatar(
              radius:80,
              backgroundImage:_imageFile == null
                  ?AssetImage('assets/profile.jpg')
                  :FileImage(File(_imageFile.path)),
            ),
            Positioned(
              bottom:20,
              right:20,
              child: InkWell(
                  onTap:(){
                    showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size:40,
                  )
              ),
            )
          ],
        )
    );
  }


  /*
  Widget imageProfile(){
    return Center(
      child:Stack(
        children: <Widget>[
          CircleAvatar(
            radius:80,
            backgroundImage:_imageFile == null
                ?AssetImage('assets/profile.jpg')
                :FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom:20,
            right:20,
            child: InkWell(
              onTap:(){
                showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.black,
                size:40,
            )
            ),
          )
        ],
      )
    );
  }

   */

  Widget nameTextField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:Colors.black,
            width:2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        labelText: 'Name',
        hintText: 'Input your name'
      ),
    );
  }


  Widget bottomSheet(){
    return Container(
      height:100,
      width:MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal:20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize:20,
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton.icon(
                icon:Icon(Icons.camera, size:50),
                onPressed:(){
                  takePhoto(ImageSource.camera);
                },
                label:Text('Camera', style: TextStyle(fontSize:20),),
              ),
              FlatButton.icon(
                  onPressed: (){
                    takePhoto(ImageSource.gallery);
                    },
                  icon: Icon(Icons.photo_library, size:50,),
                  label: Text('Gallery', style: TextStyle(fontSize:20),),
              )
            ],
          )
        ]
      )
    );
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source:source);
    setState((){
      _imageFile = pickedFile;
    });
  }

}