import 'dart:async';
import 'package:flutter/material.dart';

import '../responsive/mobile_body.dart';
import '../responsive/responsive_layout.dart';
import '../widgets/bottombar_item.dart';
import '../theme/colors.dart';
import 'ControlPage.dart';
import 'SettingsPage.dart';
import 'StatusPage.dart';


class Home extends StatefulWidget {
  const Home({Key ? key, required this.token, this.id, required this.user, required this.password}

      );
  final String user;
  final String password;
  final String token;
  final String? id;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    // print("Home Token: $_token");
    // print("Token user login: ${widget._token.toString()}");
    return Container(
      decoration: BoxDecoration(
        color: appBgColor.withOpacity(.95),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40)
        ),
      ),

      child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: getBottomBar(),
          // Nếu có floatingActionButton thì không các button sẽ bị vo hiệu hóa không hoạt động.
          // floatingActionButton: getHomeButton(),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          body: getBarPage()
      ),
    );
  }
  Widget getHomeButton(){
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Container(
      margin: EdgeInsets.only(top: 28*heightR),
      // padding: EdgeInsets.all(30*heightR),
      child: GestureDetector(
        onTap: () {
          // activeTab = 0;
          setState(() {
           activeTab = 0;
          });
        },
      ),
    );
  }

  Widget getBottomBar() {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Container(
      height: 100*heightR,
      width: double.infinity,
      decoration: BoxDecoration(
          color: mainColor,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(25),
          //   topRight: Radius.circular(25)
          // ),
          boxShadow: [
            BoxShadow(
                color: mainColor.withOpacity(0.1),
                blurRadius: .5,
                spreadRadius: .5,
                offset: Offset(0, 1)
            )
          ]
      ),
      child: Padding(
          padding:  EdgeInsets.only(top:15*heightR,left: 125*widthR, right: 125*widthR),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BottomBarItem(
                  Icons.desktop_mac_outlined,
                  "STATUS",
                  isActive: activeTab == 0,
                  activeColor: secondary,
                  onTap: () {
                    setState(() {
                      activeTab = 0;
                    });
                  },
                ),
                BottomBarItem(
                  Icons.settings,
                  "SETTINGS",
                  isActive: activeTab == 1,
                  activeColor: secondary,
                  onTap: () {
                    setState(() {
                      activeTab = 1;
                    });
                  },
                ),
                BottomBarItem(
                  Icons.swap_horiz,
                  "CONTROL",
                  isActive: activeTab == 2,
                  activeColor: secondary,
                  onTap: () {
                    setState(() {
                      activeTab = 2;
                    });
                  },
                ),
              ]
          )
      ),
    );
  }

  Widget getBarPage(){

    return
      IndexedStack(
        index: activeTab,
        children: <Widget>[
          ResponsiveLayout(
              mobileBody: MymobileBodySTT(widget.token.toString(),widget.id.toString(),widget.user,widget.password),
              desktopBody: StatusPage( token: widget.token.toString(),id: widget.id, user: widget.user, password: widget.password,)),
          ResponsiveLayout(
              mobileBody: MymobileBodySTS(widget.token.toString(),widget.id.toString(),widget.user,widget.password),
              desktopBody: SettingsPage( token: widget.token.toString(),id1: widget.id, user: widget.user, password: widget.password,)),
          ControlPage(name: "za", token: widget.token.toString(), pc: 'Cha',id1: widget.id, user: widget.user, password: widget.password,),
        ],
      );
  }
}
