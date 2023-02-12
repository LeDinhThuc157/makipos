import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../main.dart';
import 'SettingsPage.dart';
import 'StatusPage.dart';
import 'empty_page.dart';
import 'home.dart';

void main() async {
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    Widget example1 = SplashScreenView(
      navigateRoute: SignPage(),
      duration: 5000,
      imageSize: 300,
      imageSrc: "assets/logo_appthuepin.png",
      text: "BK Lab Manager",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 220*curR,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      home: example1,
      theme: _themeData(Brightness.light),
      darkTheme: _themeData(Brightness.light),
    );
  }
}

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {

  bool showPass = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _statusCode;
  var token = "";
  var _userNameError = "Tài khoản không hợp lệ";
  var _passwordError = "Mật khẩu phải trên 6 kí tự ";



  Widget _entryField(
      bool obscure,
      String title,
      TextEditingController controller,
      ) {
    return TextField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          // borderSide:
          // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
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
        backgroundColor: Colors.white,
        body: Padding(
            padding:  EdgeInsets.all(13*curR),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding:  EdgeInsets.only(top: 10*curR,left: 10*curR,right: 10*curR,bottom: 10*curR),
                    margin: EdgeInsets.only(top: 70 * heightR),
                    child:  Text(
                      'Welcome Back!',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 200 * curR),
                    )),
                Container(
                  // color: Colors.red,
                  height: 450*heightR,
                  padding:  EdgeInsets.all(40*heightR),
                  margin: EdgeInsets.only(bottom: 30*heightR),
                  alignment: Alignment.center,
                  child: Image.asset('assets/logo_appthuepin.png'),
                ),
                Container(
                    padding:  EdgeInsets.fromLTRB(60*widthR, 0, 60*widthR, 10*heightR),
                    child: _entryField(false,'User Name', nameController)
                ),
                Container(
                  padding:  EdgeInsets.fromLTRB(60*widthR, 10*heightR, 60*widthR, 0),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      _entryField(
                        !showPass,
                        'Password',
                        passwordController,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child:  Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 100*curR,
                      ),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     //forgot password screen
                //   },
                //   child: const Text(
                //     'Forgot Password?',
                //   ),
                // ),
                Container(
                    height: 200*heightR,
                    margin: EdgeInsets.only(top: 60*heightR),
                    padding:  EdgeInsets.fromLTRB(60*widthR, 0, 60*widthR, 0),
                    child: ElevatedButton(
                      child:  Text(
                        'Login',
                        style: TextStyle(fontSize: 150*curR),
                      ),
                      onPressed: () {
                        setState(() {
                          _onLoginClick();
                        });
                        print("Trạng thái Code: $_statusCode");

                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 200*widthR),
                      child: Text('Do not have an account?',
                        style: TextStyle(
                          fontSize: 105*curR,
                        ),),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 170*widthR),
                        child: TextButton(
                          child:  Text(
                            'Sign up',
                            style: TextStyle(fontSize: 110*curR),
                          ),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) => StatusPage(),
                            // ));
                          },
                        )
                    ),
                  ],
                ),
              ],
            ))
    );
  }

  _onLoginClick() async {
    try{
      var response_user_login = await http.post(
          Uri.parse(
              "https://smarthome.test.makipos.net:3029/users-service/users/authentication?_v=1"),
          headers: {
            "Content-type": "application/json; charset=utf-8",
          },
          body: jsonEncode({
            "authCode": false,
            "strategy": "local",
            "username": "${nameController.text}",
            "password": "${passwordController.text}"
          })
      );
      _statusCode = response_user_login.statusCode;
      if(_statusCode == 201){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Home(token),
        )
        );
      }
      else{
        AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.error,
          showCloseIcon: true,
          title: 'Đang nhập thất bại',
          desc:
          'Kiểm tra lại thông tin đăng nhập của bạn!',
          btnOkOnPress: () {
          },
          btnOkIcon: Icons.check_circle,
          onDismissCallback: (type) {
          },
        ).show();
      }
      print(_statusCode);
      Map<String, dynamic> userMap = jsonDecode(response_user_login.body);
      token = userMap["accessToken"].toString();
    } catch (e) {
      print(e);
    }
    return token;
  }
}
ThemeData _themeData(Brightness brightness) {
  return ThemeData(
    fontFamily: "Poppins",
    brightness: brightness,
    // Matches app icon color.
    primarySwatch:  MaterialColor(0xFF4D8CFE, <int, Color>{
      50: Color(0xFFEAF1FF),
      100: Color(0xFFCADDFF),
      200: Color(0xFFA6C6FF),
      300: Color(0xFF82AFFE),
      400: Color(0xFF689DFE),
      500: Color(0xFF4D8CFE),
      600: Color(0xFF4684FE),
      700: Color(0xFF3D79FE),
      800: Color(0xFF346FFE),
      900: Color(0xFF255CFD),
    }),
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      errorStyle: TextStyle(height: 0.75),
      helperStyle: TextStyle(height: 0.75),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40),
    )),
    scaffoldBackgroundColor: brightness == Brightness.dark
        ? Colors.black
        : null,
    cardColor: brightness == Brightness.dark
        ? Color.fromARGB(255, 28, 28, 30)
        : null,
    dialogTheme: DialogTheme(
      backgroundColor: brightness == Brightness.dark
          ? Color.fromARGB(255, 28, 28, 30)
          : null,
    ),
    highlightColor: brightness == Brightness.dark
        ? Color.fromARGB(255, 44, 44, 46)
        : null,
    splashFactory: NoSplash.splashFactory,
  );
}

