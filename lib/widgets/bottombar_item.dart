import 'package:flutter/material.dart';

import '../theme/colors.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem(this.icon, this.title,
      {this.onTap, this.color = inActiveIcon, this.activeColor = primary, this.isActive = false, this.isNotified = false});
  final IconData icon;
  final String title;
  final Color color;
  final Color activeColor;
  final bool isNotified;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    return GestureDetector(
      onTap: onTap,
      child: Column(
              children: [
                isNotified ?
                new Stack(
                  children: <Widget>[
                    new Icon(icon, size: 56*heightR, color: isActive ? activeColor : activeColor.withOpacity(.4),),
                    new Positioned( 
                      top: 5.0*heightR,
                      right: 0*heightR,
                      left: 8.0*heightR,
                      child: 
                        Padding(
                          padding: EdgeInsets.only(left: 20*heightR),
                          child: new Icon(Icons.brightness_1, size: 10.0*heightR, color: Colors.red),
                        ),
                    )
                  ]
                ) 
                :
                new Icon(icon, size: 54*heightR, color: isActive ? activeColor : activeColor.withOpacity(.4),),
                Text(title, style: TextStyle(fontSize: 22*heightR, color: isActive ? activeColor : activeColor.withOpacity(.5))),
              ],
            ),
    );  
  }
}