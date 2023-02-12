
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/custom_appbar.dart';

class  ControlPage extends StatefulWidget {

  ControlPage(this.trailing, this.name, this._token,this._pc ,{this.isOn = false,});

  final Widget? trailing;
  String name;
  bool isOn;
  final String _token;
  final String _pc;
  @override
  State<ControlPage> createState() => _ControlPageState();
}
final List<ControlPage> appliances = [
  ControlPage(Icon(Icons.battery_charging_full), 'Charge',"",'charging_mos_switch'),
  ControlPage(Icon(Icons.battery_saver), 'Discharge',"",'discharge_mos_switch'),
  ControlPage(Icon(Icons.balance), 'Balance',"",''),
  ControlPage(Icon(Icons.emergency), 'Emerfency',"",''),
  ControlPage(Icon(Icons.heat_pump),'Heating',"",''),
  ControlPage(Icon(Icons.device_thermostat), 'Disable Temp.Sensor',"",''),
  ControlPage(Icon(Icons.heart_broken), 'GPS Heartbeat',"",''),
  ControlPage(Icon(Icons.desktop_windows), 'Display Always On',"",''),
];

class _ControlPageState extends State<ControlPage> {
  String id = "635a3bee7f5e970007ecbe57";
  @override

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
                    return SwitchListTile(
                      title: Text('${appliances[index].name}'),

                      value: appliances[index].isOn,
                      onChanged: (bool value) {
                        print("Value: ${value}");
                        setState(() {
                          appliances[index].isOn = value;
                          print("Click: ${appliances[index].isOn}");

                        });
                        if(appliances[index].isOn == false){
                          setState(() {
                            postDataControl(id,appliances[index]._pc,0);
                          });
                          print("Xac nhan OFF: ${appliances[index].isOn}");
                        }
                        if(appliances[index].isOn == true){
                          setState(() {
                            postDataControl(id,appliances[index]._pc,1);
                          });
                          print("Xac nhan ON: ${appliances[index].isOn}");
                        }

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

postDataControl(final id,final propertyCode, final value) async{

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
              "commandString": "{\"d\":$value}",
              "waitResponse": false,
              "timeout": 1000
            }
        )
    );
    print("StatusControl $propertyCode : ${response_control.statusCode}");
  } catch(e){
    print(e);
  }
}

}





