import 'package:flutter/material.dart';
import 'package:novel_crawler_by_rockefeller/MyControls.dart';
import 'package:novel_crawler_by_rockefeller/SiteList.dart';


class MyHomePage extends StatelessWidget {
  Column _buttonGenerate(BuildContext context)
  {
    SiteList.reset();
    SiteList.addSite("CZBook", "czbooks.net");
    return SiteList.generateWidget(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyControls.commonAppBar("",()=>{}),
      body:new Container(margin: EdgeInsets.all(50),padding: EdgeInsets.symmetric(horizontal: 80),color: Colors.orangeAccent,child: _buttonGenerate(context),),
      drawerEnableOpenDragGesture: true,
    );
  }
}