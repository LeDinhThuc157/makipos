import 'dart:convert';
import 'dart:html';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import '../widgets/custom_appbar.dart';
import 'create_user.dart';
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
  final Storage _localStorage = window.localStorage;
  Future save(String data, String propertyCode) async {
    _localStorage['$propertyCode'] = data;
  }
  var token = "";
  var id_device = "";
  String? dataname ;
  String? datapass ;
  Future<String?> _Username() async => dataname = _localStorage['username'];
  Future<String?> _Password() async => datapass = _localStorage['password'];
  Future<String?> _Token() async => token = _localStorage['Token']!;
  Future<String?> _Id() async => id_device = _localStorage['Id_device']!;
  Loading_Home() async {
    _Id();_Username();_Password();
    var response_user_login = await http.post(
        Uri.parse(
            "http://smarthome.test.makipos.net:3028/users-service/users/authentication?_v=1"),
        headers: {
          "Content-type": "application/json; charset=utf-8",
        },
        body: jsonEncode({
          "authCode": false,
          "strategy": "local",
          "username": "${dataname}",
          "password": "${datapass}"
        })
    );
    Map<String, dynamic> userMap = jsonDecode(response_user_login.body);
    token = userMap["accessToken"].toString();
    if(response_user_login.statusCode == 201){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Home(),
      ));
      getData(token,id_device);
      save(token, 'Token');
    }else{
    }
  }
  getData(var token, var id_device) async {
    try {
      var responseGet_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices/$id_device"),
        headers: {"Authorization": token},
      );
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);

      var cells_vol = userMap["propertiesValue"]["cells_vol"];
      save(userMap["status"],"status_device");
      save(cells_vol.toString(), "List_Cell");
      // saveList(userMap["propertiesValue"]["cells_vol"], "cells_vol");
      // bat_vol = userMap["propertiesValue"]["bat_vol"].toString();
      save(userMap["propertiesValue"]["bat_vol"].toString(), "bat_vol");
      // bat_cap = userMap["propertiesValue"]["bat_cap"].toString();
      save(userMap["propertiesValue"]["bat_cap"].toString(), "bat_cap");
      // bat_capacity = userMap["propertiesValue"]["bat_capacity"].toString();
      save(userMap["propertiesValue"]["bat_capacity"].toString(), "bat_capacity");
      // bat_temp = userMap["propertiesValue"]["bat_temp"].toString();
      save(userMap["propertiesValue"]["bat_temp"].toString(), "bat_temp");
      // bat_percent = userMap["propertiesValue"]["bat_percent"].toString();
      save(userMap["propertiesValue"]["bat_percent"].toString(), "bat_percent");
      // bat_cycles = userMap["propertiesValue"]["bat_cycles"].toString();
      save(userMap["propertiesValue"]["bat_cycles"].toString(), "bat_cycles");
      // box_temp = userMap["propertiesValue"]["box_temp"].toString();
      save(userMap["propertiesValue"]["box_temp"].toString(), "box_temp");
      // system_working_time = userMap["propertiesValue"]["logger_status"].toString();
      save(userMap["propertiesValue"]["uptime"].toString(), "uptime");
      save(userMap["propertiesValue"]["logger_status"].toString(), "logger_status");
      save(userMap["propertiesValue"]["tube_temp"].toString(), "tube_temp");

      save(userMap["propertiesValue"]["charging_mos_switch"].toString(), "charging_mos_switch");
      save(userMap["propertiesValue"]["discharge_mos_switch"].toString(), "discharge_mos_switch");
      save(userMap["propertiesValue"]["active_equalization_switch"].toString(), "active_equalization_switch");
      // charge = userMap["propertiesValue"]["charging_mos_switch"].toString();
      // discharge = userMap["propertiesValue"]["discharge_mos_switch"].toString();
      // balance = userMap["propertiesValue"]["active_equalization_switch"].toString();
      // mos_temp = userMap["propertiesValue"]["tube_temp"].toString();
      // bat_current = (int.parse(userMap["propertiesValue"]["bat_current"].toString()) * 0.01).toString();
      save((int.parse(userMap["propertiesValue"]["bat_current"].toString()) * 0.01).toString(), "bat_current");
      var min = cells_vol[0];
      var max = cells_vol[0];
      var sum = cells_vol.reduce((value, current) => value + current);
      for (var i = 0; i < cells_vol.length; i++) {
        // Calculate sum
        // sum += cells_vol[i];
        // Checking for largest value in the list
        if (cells_vol[i] > max) {
          max = cells_vol[i];
        }
        // Checking for smallest value in the list
        if (cells_vol[i] < min) {
          min = cells_vol[i];
        }
      }
      // cell_diff = ((max - min)*0.001).toStringAsFixed(4);
      save(((max - min)*0.001).toStringAsFixed(4), "cell_diff");
      // ave_cell = (sum / (cells_vol.length)).toStringAsFixed(2);
      save((sum / (cells_vol.length)).toStringAsFixed(2), "ave_cell");

      // Setting data

      // _cellOVP = userMap["propertiesValue"]["single_overvoltage"].toString();
      save(userMap["propertiesValue"]["single_overvoltage"].toString(), "single_overvoltage");
      // _cellOVPR = userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString();
      save(userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString(), "monomer_overvoltage_recovery");
      // _cellUVPR = userMap["propertiesValue"]["discharge_overcurrent_protection_value"].toString();
      save(userMap["propertiesValue"]["discharge_overcurrent_protection_value"].toString(), "discharge_overcurrent_protection_value");
      // _cellUVP = userMap["propertiesValue"]["differential_voltage_protection_value"].toString();
      save(userMap["propertiesValue"]["differential_voltage_protection_value"].toString(), "differential_voltage_protection_value");
      // _continuedChargeCurr = userMap["propertiesValue"]["equalizing_opening_differential"].toString();
      save(userMap["propertiesValue"]["equalizing_opening_differential"].toString(), "equalizing_opening_differential");
      // _continuedDischargeCurr = userMap["propertiesValue"]["charging_overcurrent_delay"].toString();
      save(userMap["propertiesValue"]["charging_overcurrent_delay"].toString(), "charging_overcurrent_delay");
      // _dischargeOCPdelay = userMap["propertiesValue"]["equalizing_starting_voltage"].toString();
      save(userMap["propertiesValue"]["equalizing_starting_voltage"].toString(), "equalizing_starting_voltage");
      // _chargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString();
      save(userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString(), "high_temp_protect_bat_charge");
      // _dischargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_discharge"].toString();
      save(userMap["propertiesValue"]["high_temp_protect_bat_discharge"].toString(), "high_temp_protect_bat_discharge");
      // _chargeUTP = userMap["propertiesValue"]["charge_cryo_protect"].toString();
      save(userMap["propertiesValue"]["charge_cryo_protect"].toString(), "charge_cryo_protect");
      // _chargeUTPR =  userMap["propertiesValue"]["recover_val_charge_cryoprotect"].toString();
      save(userMap["propertiesValue"]["recover_val_charge_cryoprotect"].toString(), "recover_val_charge_cryoprotect");
      // _startBalanceVolt = userMap["propertiesValue"]["tube_temp_protection"].toString();
      save(userMap["propertiesValue"]["tube_temp_protection"].toString(), "tube_temp_protection");
      // _cellcount = userMap["propertiesValue"]["strings_settings"].toString();
      save(userMap["propertiesValue"]["strings_settings"].toString(), "strings_settings");
      // _batterycapacity = userMap["propertiesValue"]["battery_capacity_settings"].toString();
      save(userMap["propertiesValue"]["battery_capacity_settings"].toString(), "battery_capacity_settings");
    } catch (e) {
      print(e);
    }
    // Boolvalue();

  }

  @override
  void initState(){
    super.initState();
    _Token();
    token == "" ? 1 : Loading_Home();
  }
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
      text: "Loading",
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
  var id_device = "";
  var name_device = "";

  String? dataname ;
  String? datapass ;

@override
void initState(){
  super.initState();
  _GetDataSave();
  _statusCode == null ? 1 : _statusCode;
}
  Future<String?> _Username() async => dataname = _localStorage['username'];
  Future<String?> _Password() async => datapass = _localStorage['password'];
  Future<String?> _Status() async => _statusCode = _localStorage['Status'];

  _GetDataSave(){
    _Username();
    _Password();
    _Status();
    setState(() {
      dataname != null ? nameController.text = dataname! : "";
      datapass != null ? passwordController.text = datapass! : "";
    });

}
  // Widget _entryField(
  //     bool obscure,
  //     String title,
  //     TextEditingController controller,
  //     ) {
  //   return TextField(
  //     obscureText: obscure,
  //     controller: controller,
  //     decoration: InputDecoration(
  //       enabledBorder: OutlineInputBorder(
  //         // borderSide:
  //         // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
  //         borderRadius: BorderRadius.circular(20.0),
  //       ),
  //       labelText: title,
  //     ),
  //   );
  // }

  final Storage _localStorage = window.localStorage;
  Future save(String data, String propertyCode) async {
    _localStorage['$propertyCode'] = data;
  }
  // Future save_list(List data, String propertyCode) async {
  //   _localStorage['$propertyCode'] = data as String;
  // }
  @override
  Widget build(BuildContext context) {

    // print("$dataname : $datapass");
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
                    // margin: EdgeInsets.only(top: 70 * heightR),
                    child:  Text(
                      'Welcome Back!',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 160 * curR),
                    )),
                Container(
                  // color: Colors.red,
                  height: 400*heightR,
                  padding:  EdgeInsets.all(40*heightR),
                  margin: EdgeInsets.only(bottom: 30*heightR),
                  alignment: Alignment.center,
                  child: Image.asset('assets/logo_appthuepin.png'),
                ),
                Container(
                    padding:  EdgeInsets.fromLTRB(60*widthR, 0, 60*widthR, 10*heightR),
                    child: TextFormField(
                      controller: nameController,
                      decoration:  InputDecoration(
                        labelText: 'Enter your Username',
                      ),
                    ),
                ),
                Container(
                  padding:  EdgeInsets.fromLTRB(60*widthR, 10*heightR, 60*widthR, 0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: "Enter your Password",
                      // suffixIcon: IconButton(
                      //     icon: Icon(
                      //       showPass ? Icons.visibility : Icons.visibility_off,
                      //       semanticLabel: showPass ? 'hide password' : 'show password',
                      //     ),
                      //     onPressed: () {
                      //       setState(() {
                      //         setState(() {
                      //           showPass = !showPass;
                      //         });
                      //         //print("Icon button pressed! state: $_passwordVisible"); //Confirmed that the _passwordVisible is toggled each time the button is pressed.
                      //       });
                      //     }),
                    ),
                    obscureText: !showPass,

                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                    //   Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => LineChartSample1(),
                    //   )
                    //   );
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.leftSlide,
                        headerAnimationLoop: false,
                        dialogType: DialogType.error,
                        showCloseIcon: true,
                        title: 'Notification',
                        desc:
                        'Vui lòng liên hệ với quản trị viên để lấy lại mật khẩu!',
                        btnOkOnPress: () {
                        },
                        btnOkIcon: Icons.cancel,
                        onDismissCallback: (type) {
                        },
                      ).show();
                    },
                    child:  Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 60*curR,
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 150*heightR,
                    margin: EdgeInsets.only(top: 20*heightR),
                    padding:  EdgeInsets.fromLTRB(60*widthR, 0, 60*widthR, 0),
                    child: ElevatedButton(
                      child:  Text(
                        'Login',
                        style: TextStyle(fontSize: 120*curR),
                      ),
                      onPressed: () {
                        setState(() {
                          _SaveLogin();
                        }
                        );

                        },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 200*widthR),
                      child: Text('Do not have an account?',
                        style: TextStyle(
                          fontSize: 80*curR,
                        ),),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 170*widthR),
                        child: TextButton(
                          child:  Text(
                            'Sign up',
                            style: TextStyle(fontSize: 80*curR),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => CreateUser(),
                            ));
                          },
                        )
                    ),
                  ],
                ),
              ],
            ))
    );
  }
  _SaveLogin() async {
    try{
      var response_user_login = await http.post(
          Uri.parse(
              "http://smarthome.test.makipos.net:3028/users-service/users/authentication?_v=1"),
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
      Map<String, dynamic> userMap = jsonDecode(response_user_login.body);
      token = userMap["accessToken"].toString();
      if(_statusCode == 201){
        save(nameController.text,'username');
        save(passwordController.text,'password');
        save(token, "Token");
        get_device(token);
        save(_statusCode.toString(),'Status');
        // Login
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Home(),
        ));
      }else{
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


    } catch (e) {
      print(e);
    }
    return token;
  }
  get_device(var token) async {
    try{
      var Get_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices"),
        headers: {"Authorization": token},
      );
      Map<String, dynamic> userMap = jsonDecode(Get_Listdevice.body);
      id_device = userMap["data"][0]["_id"].toString();
      save(id_device,"Id_device");
      name_device = userMap["data"][0]["productId"].toString();
      save(name_device, "Name_device");
      getData(token);

    }catch(e){
      print(e);
    }
  }
  getData(var token) async {
    try {
      var responseGet_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices/$id_device"),
        headers: {"Authorization": token},
      );
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);

      var cells_vol = userMap["propertiesValue"]["cells_vol"];
      save(userMap["status"],"status_device");
      save(cells_vol.toString(), "List_Cell");
      // saveList(userMap["propertiesValue"]["cells_vol"], "cells_vol");
      // bat_vol = userMap["propertiesValue"]["bat_vol"].toString();
      save(userMap["propertiesValue"]["bat_vol"].toString(), "bat_vol");
      // bat_cap = userMap["propertiesValue"]["bat_cap"].toString();
      save(userMap["propertiesValue"]["bat_cap"].toString(), "bat_cap");
      // bat_capacity = userMap["propertiesValue"]["bat_capacity"].toString();
      save(userMap["propertiesValue"]["bat_capacity"].toString(), "bat_capacity");
      // bat_temp = userMap["propertiesValue"]["bat_temp"].toString();
      save(userMap["propertiesValue"]["bat_temp"].toString(), "bat_temp");
      // bat_percent = userMap["propertiesValue"]["bat_percent"].toString();
      save(userMap["propertiesValue"]["bat_percent"].toString(), "bat_percent");
      // bat_cycles = userMap["propertiesValue"]["bat_cycles"].toString();
      save(userMap["propertiesValue"]["bat_cycles"].toString(), "bat_cycles");
      // box_temp = userMap["propertiesValue"]["box_temp"].toString();
      save(userMap["propertiesValue"]["box_temp"].toString(), "box_temp");
      // system_working_time = userMap["propertiesValue"]["logger_status"].toString();
      save(userMap["propertiesValue"]["uptime"].toString(), "uptime");
      save(userMap["propertiesValue"]["logger_status"].toString(), "logger_status");
      save(userMap["propertiesValue"]["tube_temp"].toString(), "tube_temp");

      save(userMap["propertiesValue"]["charging_mos_switch"].toString(), "charging_mos_switch");
      save(userMap["propertiesValue"]["discharge_mos_switch"].toString(), "discharge_mos_switch");
      save(userMap["propertiesValue"]["active_equalization_switch"].toString(), "active_equalization_switch");
      // charge = userMap["propertiesValue"]["charging_mos_switch"].toString();
      // discharge = userMap["propertiesValue"]["discharge_mos_switch"].toString();
      // balance = userMap["propertiesValue"]["active_equalization_switch"].toString();
      // mos_temp = userMap["propertiesValue"]["tube_temp"].toString();
      // bat_current = (int.parse(userMap["propertiesValue"]["bat_current"].toString()) * 0.01).toString();
      save((int.parse(userMap["propertiesValue"]["bat_current"].toString()) * 0.01).toString(), "bat_current");
      var min = cells_vol[0];
      var max = cells_vol[0];
      var sum = cells_vol.reduce((value, current) => value + current);
      for (var i = 0; i < cells_vol.length; i++) {
        // Calculate sum
        // sum += cells_vol[i];
        // Checking for largest value in the list
        if (cells_vol[i] > max) {
          max = cells_vol[i];
        }
        // Checking for smallest value in the list
        if (cells_vol[i] < min) {
          min = cells_vol[i];
        }
      }
      // cell_diff = ((max - min)*0.001).toStringAsFixed(4);
      save(((max - min)*0.001).toStringAsFixed(4), "cell_diff");
      // ave_cell = (sum / (cells_vol.length)).toStringAsFixed(2);
      save((sum / (cells_vol.length)).toStringAsFixed(2), "ave_cell");

      // Setting data

      // _cellOVP = userMap["propertiesValue"]["single_overvoltage"].toString();
      save(userMap["propertiesValue"]["single_overvoltage"].toString(), "single_overvoltage");
      // _cellOVPR = userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString();
      save(userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString(), "monomer_overvoltage_recovery");
      // _cellUVPR = userMap["propertiesValue"]["discharge_overcurrent_protection_value"].toString();
      save(userMap["propertiesValue"]["discharge_overcurrent_protection_value"].toString(), "discharge_overcurrent_protection_value");
      // _cellUVP = userMap["propertiesValue"]["differential_voltage_protection_value"].toString();
      save(userMap["propertiesValue"]["differential_voltage_protection_value"].toString(), "differential_voltage_protection_value");
      // _continuedChargeCurr = userMap["propertiesValue"]["equalizing_opening_differential"].toString();
      save(userMap["propertiesValue"]["equalizing_opening_differential"].toString(), "equalizing_opening_differential");
      // _continuedDischargeCurr = userMap["propertiesValue"]["charging_overcurrent_delay"].toString();
      save(userMap["propertiesValue"]["charging_overcurrent_delay"].toString(), "charging_overcurrent_delay");
      // _dischargeOCPdelay = userMap["propertiesValue"]["equalizing_starting_voltage"].toString();
      save(userMap["propertiesValue"]["equalizing_starting_voltage"].toString(), "equalizing_starting_voltage");
      // _chargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString();
      save(userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString(), "high_temp_protect_bat_charge");
      // _dischargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_discharge"].toString();
      save(userMap["propertiesValue"]["high_temp_protect_bat_discharge"].toString(), "high_temp_protect_bat_discharge");
      // _chargeUTP = userMap["propertiesValue"]["charge_cryo_protect"].toString();
      save(userMap["propertiesValue"]["charge_cryo_protect"].toString(), "charge_cryo_protect");
      // _chargeUTPR =  userMap["propertiesValue"]["recover_val_charge_cryoprotect"].toString();
      save(userMap["propertiesValue"]["recover_val_charge_cryoprotect"].toString(), "recover_val_charge_cryoprotect");
      // _startBalanceVolt = userMap["propertiesValue"]["tube_temp_protection"].toString();
      save(userMap["propertiesValue"]["tube_temp_protection"].toString(), "tube_temp_protection");
      // _cellcount = userMap["propertiesValue"]["strings_settings"].toString();
      save(userMap["propertiesValue"]["strings_settings"].toString(), "strings_settings");
      // _batterycapacity = userMap["propertiesValue"]["battery_capacity_settings"].toString();
      save(userMap["propertiesValue"]["battery_capacity_settings"].toString(), "battery_capacity_settings");
    } catch (e) {
      print(e);
    }
    // Boolvalue();

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

