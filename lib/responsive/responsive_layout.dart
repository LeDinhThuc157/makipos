import 'package:flutter/material.dart';
import 'package:makipos/view/StatusPage.dart';

class ResponsiveLayout extends StatelessWidget{
  final Widget mobileBody;
  final Widget desktopBody;
  ResponsiveLayout({required this.mobileBody, required this.desktopBody});

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < 600){
            return mobileBody;
          }else{
            return desktopBody;
          }
        }
    );
  }
}