import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_universal/websocket_universal.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class EmptyPage extends StatefulWidget {

  @override
  _EmptyPageState createState() => _EmptyPageState();
}
class _EmptyPageState extends State<EmptyPage> {

  // var email;
  // var password;
  // var _cookie;
  // var serverUrl = "smarthome.test.makipos.net";
  // Future<void> _getConnection({String protocol = "https", required String email, required String password}) async {
  //
  //   final addr = "https://smarthome.test.makipos.net:3029/users-service/users/authentication?_v=1";
  //   final body = jsonEncode({
  //     "authCode": false,
  //     "strategy": "local",
  //     "username": "${email}",
  //     "password": "${password}"
  //   });
  //
  //   final response = await Dio().post(
  //       addr,
  //       data: body,
  //       options: new Options(
  //         headers: {
  //       "Content-type": "application/json; charset=utf-8",
  //       },
  //       ));
  //   _cookie = response.data['accessToken'];
  //   new WebSocketChannel.connect(Uri.parse("ws://smarthome.test.makipos.net:3029/api/foo/ws?authorization=$_cookie"));
    // final conext = WebSocketChannel.connect(
    //     Uri.parse("ws://localhost:8080/api/foo/ws?authorization=$_cookie"));
    // print(_cookie);
  @override
  Widget build(BuildContext context) {


    IO.Socket socket = IO.io("wss://smarthome.test.makipos.net:8084",
        OptionBuilder(
        )
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders(
            {
              'Username':'BMS_admin',
              'Password':'01012023',
              'ClientID':'BMS_admin'
            }
        )
       .build()
    );
    print("Connect: ${socket.connected}");
    print("Connect1: ${socket.auth}");
    // socket.onConnect((_) {
    //   print('connect');
    //   socket.emit('msg', 'test');
    // });
    // socket.on('event', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));



    // // conext.sink.add(
    // //
    // //   jsonEncode({
    // //     'Username':'BMS_admin',
    // //               'Password':'01012023',
    // //   }),
    // // );
    // conext.stream.listen((event) {
    //   print(event);
    // });
    return Text("data");
  }

}
