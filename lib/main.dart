
import 'package:flutter/material.dart';
import 'package:makipos/view/StatusPage.dart';
import 'package:makipos/view/empty_page.dart';
import 'package:makipos/view/login.dart';
import 'view/home.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner : false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LogInPage(),
    );
  }
}

// import 'dart:async';
// import 'dart:convert';
// import 'dart:html';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:http/http.dart';
// import 'package:makipos/theme/colors.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// void main() {
//   // final channel = WebSocketChannel.connect(Uri.parse("ws://smarthome.test.makipos.net:8083/mqtt"));
//   // channel.stream.listen((event) {
//   //   print(event);
//   // });
//
//   final ketnoiu = WebSocketChannel.connect(Uri.parse("ws://smarthome.test.makipos.net:8083/mqtt",)).protocol;
//
//   connectToWebSocket();
// }
//
// void connectToWebSocket() {
//   print("trying to connect to websocket");
//
//   var channel;
//   var webSocketConnected;
//   var webSocketConnectionError;
//   Future<WebSocketChannel> establishConnection() async {
//     final WebSocketChannel channel = WebSocketChannel.connect(
//         Uri(
//             scheme: "ws",
//             host: "smarthome.test.makipos.net",
//             port: 8083,
//             path: "mqtt",
//         )
//     );
//
//     return channel;
//   }
//   final Future futureChannel = establishConnection();
//   futureChannel.then((future) {
//     print("Connection established, registering interest now... ");
//     channel = future;
//     webSocketConnected = true;
//     channel.sink.add(
//
//         // "BMS_admin", 01012023
//         jsonEncode(
//             {
//               "authCode": false,
//               "strategy": "local",
//               "username": "BMS_admin",
//               "plainPassword": "01012023",
//             }),
//     );
//
//   }).catchError((error) {
//     channel = null;
//     webSocketConnected = false;
//     webSocketConnectionError = error.toString();
//     print("Connection failed \n $webSocketConnectionError ");
//   });
// }

