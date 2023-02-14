
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/custom_appbar.dart';

class  ControlPage extends StatefulWidget {

  ControlPage(this.trailing, this.name, this._token,this._pc ,{this.isOn,});

  final Widget? trailing;
  String name;
  var isOn;
  final String _token;
  final String _pc;
  @override
  State<ControlPage> createState() => _ControlPageState();

}

final List<ControlPage> appliances = [
  ControlPage(Icon(Icons.battery_charging_full), 'Charge',"",'charging_mos_switch'),
  ControlPage(Icon(Icons.battery_saver), 'Discharge',"",'discharge_mos_switch'),
  // ControlPage(Icon(Icons.balance), 'Balance',"",''),
  // ControlPage(Icon(Icons.emergency), 'Emerfency',"",''),
  // ControlPage(Icon(Icons.heat_pump),'Heating',"",''),
  // ControlPage(Icon(Icons.device_thermostat), 'Disable Temp.Sensor',"",''),
  // ControlPage(Icon(Icons.heart_broken), 'GPS Heartbeat',"",''),
  // ControlPage(Icon(Icons.desktop_windows), 'Display Always On',"",''),
];

class _ControlPageState extends State<ControlPage> {
  String id = "63be79a13ea8bc0007797118";
  var check ;
  @override
  GetDataControl() async {
    try {
      var responseGet_Listdevice = await http.get(
        Uri.parse("https://smarthome.test.makipos.net:3029/devices/$id"),
        headers: {
          "Authorization": widget._token.toString()
        },
      );
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);
      setState(() {
        var _switch = userMap["propertiesValue"]["charging_mos_switch"].toString();
        if(_switch == "1"){
          check = true;
          print("On CG:$check");
        }
        if(_switch == "0"){
          check = false;
          print("Off CG:$check");
        }

      });
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 540*heightR,
            child: Center(
                child: ListView.builder(
                  itemCount: appliances.length,
                  itemBuilder: (context, index) {
                    GetDataControl();
                    appliances[index].isOn = check;
                    print("Check1: ${appliances[index].isOn}");
                    return SwitchListTile(
                      title: Text('${appliances[index].name}'),

                      value: appliances[index].isOn,
                      onChanged: (bool value) {
                        setState(() {
                          print("Value: ${value}");
                          appliances[index].isOn = value;
                          print("Click: ${appliances[index].isOn}");
                          postDataControl(id , appliances[index]._pc, appliances[index].isOn);
                        });

                      },
                      secondary: appliances[index].trailing,
                    );

                  },
                )
            ),
          ),
          Container(
            height: 200*heightR,
            child: ListView(
              padding: EdgeInsets.all(8),
              children: <Widget>[
                ListTile(title: Text("Modify PWD"), leading: Icon(Icons.lock),onTap: (){},),
              ],
            ),
          )
        ],
      ),
    );
  }

postDataControl(final id,final propertyCode,bool check) async{

  try{
    var response_control = await http.post(
        Uri.parse(
            "http://smarthome.test.makipos.net:3028/users-control-devices"),
        headers: {
          "Content-type": "application/json",
          "Authorization": widget._token.toString()
        },
        body: jsonEncode(
            {
              "deviceId": id,
              "propertyCode": propertyCode,
              "localId": "1",
              "commandString": "{\"d\":${!check ? 0 : 1}",
              "waitResponse": false,
              "timeout": 100
            }
        )
    );

    Map<String, dynamic> userMap = jsonDecode(response_control.body);
    print("StatusControl $propertyCode : ${response_control.statusCode}"
        "Value:${response_control.body}");
    if(check) print("Bật ${!check ? 0 : 1}");
    else {
      print("Tắt ${!check ? 0 : 1}");
    }
  } catch(e){
    print(e);
  }
}

}





