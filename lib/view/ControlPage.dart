
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/custom_appbar.dart';

class  ControlPage extends StatefulWidget {
  ControlPage({Key? key,
  this.trailing,
  required this.name,
    required this.token,
    required this.pc ,
  this.isOn, this.id1
  }
): super(key: key);

  final String? id1;
  final Widget? trailing;
  String name;
  var isOn;
   String token;
   String pc;
  @override
  State<ControlPage> createState() => _ControlPageState();

}

final List<ControlPage> appliances = [
  //ControlPage(Icon(Icons.battery_charging_full), 'Charge',"",'charging_mos_switch'),
  //ControlPage(Icon(Icons.battery_saver), 'Discharge',"",'discharge_mos_switch'),
  // ControlPage(Icon(Icons.balance), 'Balance',"",''),
  // ControlPage(Icon(Icons.emergency), 'Emerfency',"",''),
  // ControlPage(Icon(Icons.heat_pump),'Heating',"",''),
  // ControlPage(Icon(Icons.device_thermostat), 'Disable Temp.Sensor',"",''),
  // ControlPage(Icon(Icons.heart_broken), 'GPS Heartbeat',"",''),
  // ControlPage(Icon(Icons.desktop_windows), 'Display Always On',"",''),
];

class _ControlPageState extends State<ControlPage> {
  var id;
  var isOn_charge ;
  var isOn_discharge ;
  var charge;
  var discharge;
  var checkct = false;
  @override
  GetDataControl(final propertyCode) async {


    try {
      String? id1 = widget.id1;
      id = id1;
      var responseGet_Listdevice = await http.get(
        Uri.parse("https://smarthome.test.makipos.net:3029/devices/$id"),
        headers: {
          "Authorization": widget.token.toString()
        },
      );

      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);

      if(userMap["data"] == null || userMap["data"].toString() == '[]' || responseGet_Listdevice.statusCode != 200){
        checkct = false;
      }else{
        checkct = true;
      }

      var _switch = userMap["propertiesValue"]["$propertyCode"].toString();
      if(propertyCode == "charging_mos_switch"){
        if(_switch == "1"){
          isOn_charge = true;
          charge = "1";
          // print("On CG $propertyCode:$isOn_charge");
        }
        if(_switch == "0"){
          isOn_charge = false;
          charge = "0";
          // print("Off CG:$isOn_charge");
        }
      }
      if(propertyCode == "discharge_mos_switch"){
        if(_switch == "1"){
          isOn_discharge = true;
          discharge = "1";
          // print("On DCG $propertyCode:$isOn_discharge");
        }
        if(_switch == "0"){
          isOn_discharge = false;
          discharge = "0";
          // print("Off DCG:$isOn_discharge");
        }
      }
    } catch (e) {
      print(e);
    }

  }

  _FetchAPI(){
    GetDataControl("charging_mos_switch");
    GetDataControl("discharge_mos_switch");
  }
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    _FetchAPI();
    return Scaffold(
      appBar: CustomAppbar(widget.token.toString()),
      backgroundColor: Colors.white,
      body:  StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 3)).asyncMap((event) => _FetchAPI()),
        builder: (context, snapshot) => !checkct ? Column(
          children: [
            Container(
              height: 100*heightR,
              child: Center(
                  child: SwitchListTile(
                      title: Row(
                        children: [
                          SizedBox(
                            width: 15*heightR,
                          ),
                          Icon(Icons.battery_charging_full),
                          SizedBox(
                            width: 35*heightR,
                          ),
                          Text('Charge'),
                        ],
                      ),
                      activeColor: Colors.teal,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.black,
                      inactiveTrackColor: Colors.blueGrey,
                      value: isOn_charge,
                      onChanged: (bool value) {
                        setState(() {
                          isOn_charge = value;
                          postDataControl(id, "charging_mos_switch", isOn_charge);
                        });
                      }
                  )
              ),
            ),
            Container(
              height: 100*heightR,
              child: Center(
                  child: SwitchListTile(
                      title: Row(
                        children: [
                          SizedBox(
                              width: 15*heightR
                          ),
                          Icon(Icons.battery_saver),
                          SizedBox(
                              width: 35*heightR
                          ),
                          Text('Discharge'),
                        ],
                      ),
                      activeColor: Colors.teal,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.black,
                      inactiveTrackColor: Colors.blueGrey,
                      value: isOn_discharge,
                      onChanged: (bool value) {
                        setState(() {
                          isOn_discharge = value;
                          postDataControl(id, "discharge_mos_switch", isOn_discharge);
                        });
                      }
                  )
              ),
            ),
            Container(
              height: 100*heightR,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: <Widget>[
                  ListTile(title: Text("Modify PWD"), leading: Icon(Icons.lock),onTap: (){},),
                ],
              ),
            ),

          ],
        ): SizedBox(),
      )
    );
  }

postDataControl(final id,final propertyCode,bool _check) async{

  try{
    var response_control = await http.post(
        Uri.parse(
            "https://smarthome.test.makipos.net:3029/users-control-devices"),
        headers: {
          "Content-type": "application/json",
          "Authorization": widget.token.toString()
        },
        body: jsonEncode(
            {
              "deviceId": id,
              "propertyCode": propertyCode,
              "localId": "1",
              "data": !_check ? 0 : 1,
              "waitResponse": false,
              "timeout": 100
            }
        )
    );

    Map<String, dynamic> userMap = jsonDecode(response_control.body);
    // print("StatusControl $propertyCode : ${response_control.statusCode}"
    //     "Value:${response_control.body}");
    // if(_check) print("Bật ${!_check ? 0 : 1}");
    // else {
    //   print("Tắt ${!_check ? 0 : 1}");
    // }
  } catch(e){
    print(e);
  }
}

}
/*
ListView.builder(
                  itemCount: appliances.length,
                  itemBuilder: (context, index) {
                    GetDataControl(appliances[index]._pc);
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
*/



