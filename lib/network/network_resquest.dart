import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class postData extends StatelessWidget {
  const postData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void main() async {
  //1.Thông tin tạo tài khoản login.
  var response_user_login = await http.post(
      Uri.parse(
          "https://smarthome.test.makipos.net:3029/users-service/users/authentication?_v=1"),
      headers: {
        "Content-type": "application/json; charset=utf-8",
// "Accept": "application/json",
// "Ocp-Apim-Subscription-Key": "63b5363c0a3a520007fa2ab9",
// "Ocp-Apim-Trace": "true"
      },
      body: jsonEncode({
//   "authCode": false,
        "strategy": "local",
        "username": "BMS_admin",
        "password": "01012023"
      })
  );
  response_user_login.body;

//2.Tạo tài khoản.

  var response_create_user = await http.post(
      Uri.parse("https://smarthome.test.makipos.net:3029/users"),
      headers: {
        "Content-type": "application/json; charset=utf-8",
// "Accept": "application/json",
// "Ocp-Apim-Subscription-Key": "63b5363c0a3a520007fa2ab9",
// "Ocp-Apim-Trace": "true"
      },
      body: jsonEncode({
//   "authCode": false,
//   "strategy": "local",
        "username": "BMS_admin",
        "password": "01012023"
      }));

//3.Thông tin all tài khoản.

  var responseGet_User = await http.get(
    Uri.parse("https://smarthome.test.makipos.net:3029/users"),
    headers: {
// "Accept": "application/json",
      "Authorization":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2I1M2M0NDYxMjVkYjAwMDdjYTIwZmMiLCJ1c2VybmFtZSI6IkJNU19hZG1pbiIsInR5cGUiOiJ1c2VyIiwiaWF0IjoxNjcyODI4NTA3LCJleHAiOjEwMzEyODI4NTA3LCJhdWQiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJpc3MiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJzdWIiOiIiLCJqdGkiOiI0MjA5OTUxNS0zZmY2LTQ0OTgtYmMxYS02NDg1MmEzM2U5ZjcifQ.HfJz87PI0G1T9nUF0doesD6sY-KTKSbZuJgaWfWN0Uo",
    },
  );
//4.Thông tin thiết bị.

  var responseGet_Listdevice = await http.get(
    Uri.parse("https://smarthome.test.makipos.net:3029/devices"),
    headers: {
      "Authorization":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2I1M2M0NDYxMjVkYjAwMDdjYTIwZmMiLCJ1c2VybmFtZSI6IkJNU19hZG1pbiIsInR5cGUiOiJ1c2VyIiwiaWF0IjoxNjcyODI4NTA3LCJleHAiOjEwMzEyODI4NTA3LCJhdWQiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJpc3MiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJzdWIiOiIiLCJqdGkiOiI0MjA5OTUxNS0zZmY2LTQ0OTgtYmMxYS02NDg1MmEzM2U5ZjcifQ.HfJz87PI0G1T9nUF0doesD6sY-KTKSbZuJgaWfWN0Uo"
    },
  );

}

