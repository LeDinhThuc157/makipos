import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController namecontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();
  TextEditingController addrcontroler = TextEditingController();
  TextEditingController phonenumbercontroler = TextEditingController();
  TextEditingController idcontroler = TextEditingController();
  TextEditingController emailcontroler = TextEditingController();

  Widget _entryFiled(
      String title,
      TextEditingController controller,
      ){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: title,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
        actions: <Widget>[
          Icon(
            Icons.folder_shared,
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20*heightR,
              ),
              SizedBox(
                height: 20*heightR,
              ),
              Container(
                margin: EdgeInsets.all(22*heightR),
                child: _entryFiled('Name', namecontroler),
              ),
              Container(
                margin: EdgeInsets.all(22*heightR),
                child: _entryFiled('Phone Number', phonenumbercontroler),
              ),
              Container(
                margin: EdgeInsets.all(22*heightR),
                child: _entryFiled('Password', passwordcontroler),
              ),
              Container(
                margin: EdgeInsets.all(22*heightR),
                child: _entryFiled('Address', addrcontroler),
              ),
              Container(
                margin: EdgeInsets.all(22*heightR),
                child: _entryFiled('Email',emailcontroler),
              ),
              Container(
                height: 150*heightR,
                margin: EdgeInsets.only(top: 70*heightR),
                padding:  EdgeInsets.fromLTRB(120*curR, 0, 120*curR, 0),
                child: ElevatedButton(
                  child: Text(
                    'Save Your Profile',
                    style: TextStyle(fontSize: 120*curR),
                  ),
                  onPressed: (){
                    _onLoginClick();
                  },
                ),

              )


            ]),
      ),
    );
  }
  _onLoginClick() async {
    try{
      var response_user_create = await http.post(
          Uri.parse(
              "http://smarthome.test.makipos.net:3028/users"),
          headers: {
            "Content-type": "application/json; charset=utf-8",
          },
          body: jsonEncode({
            "username": "${namecontroler.text}",
            "password": "${passwordcontroler.text}",
            "manufacturerId": "63b5363c0a3a520007fa2ab9",
            "roles": [
              "user"
            ],
            "PhoneNumber": "${phonenumbercontroler.text}",
            "Email":"${emailcontroler.text}",
            "Addr":"${addrcontroler.text}",

          })
      );
      Map<String, dynamic> userMap = jsonDecode(response_user_create.body);
      var _statusCode = response_user_create.statusCode;
      if(_statusCode == 201){
        AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: true,
          title: 'THÀNH CÔNG',
          desc:
          'Tạo thành công! Bạn có thể bắt đầu đăng nhập',
          btnOkOnPress: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => LogInPage(),
            ));
          },
          btnOkIcon: Icons.check_circle,
          onDismissCallback: (type) {
          },
        ).show();
      }
      else{
        AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.error,
          showCloseIcon: true,
          title: 'Tạo thất bại thất bại',
          desc:
          '${userMap["message"]["message"]}',
          btnOkOnPress: () {
          },
          btnOkIcon: Icons.check_circle,
          onDismissCallback: (type) {
          },
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }
}
