import 'package:flutter/material.dart';
import 'package:novel_crawler_by_rockefeller/MyRoute.dart';

class MyControls
{
  static Text myText(String data,Color color,double size) => new Text(data,style: new TextStyle(color: color,fontSize: size));
  static Text commonText(String data) => myText(data, Colors.black, 15);
  static Text novelTitleText(String data) => myText(data, Colors.black, 15);
  static Text novelContentText(String data) => myText(data, Colors.black, 15);
  static Widget loadingWidget()=>new Container(child: myText("Loading...",Colors.black,50),alignment: Alignment.center,);

  static ElevatedButton siteListElevatedButton(Function link,String siteName) =>
  new ElevatedButton(onPressed: link, child: myText(siteName,Colors.white,30),);

  static List<Widget> downloadAction(Function function) => <Widget>[IconButton(icon: Icon(Icons.download_outlined),onPressed: function,)];

  static AppBar commonAppBar(String barTitle,Function downloadFunction) =>
   new AppBar(title: Text(barTitle.isNotEmpty?barTitle:"Rockefeller's Novel Crawler"),actions: downloadAction(downloadFunction));

  static Drawer novelSortDrawer(List<Map<String,String>> novelSort,context)
  {
    List<Widget> elevatedButtons = new List<Widget>();
    //elevatedButtons.add(myText('Novel Sort',Colors.orangeAccent,15));
    novelSort.forEach((sort) { 
      elevatedButtons.add(
        new ElevatedButton(onPressed: ()=>{MyRoute.routeSort(sort.keys.first, sort.values.first, context)}, child: new Text(sort.keys.first))
      );
    });
    return new Drawer(
        child: Center(
          child: new ListView(
            children: elevatedButtons,)
        ),
      );
  }
}