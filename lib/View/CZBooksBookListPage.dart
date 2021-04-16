
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_crawler_by_rockefeller/MyControls.dart';
import 'package:novel_crawler_by_rockefeller/MyRoute.dart';
import 'package:novel_crawler_by_rockefeller/Novel.dart';
import 'package:novel_crawler_by_rockefeller/INovelCrawler.dart';

class CZBooksBookListPageBody extends StatefulWidget
{
  String url;
  CZBooksBookListPageBody(url){this.url=url;}
  @override
  State<StatefulWidget> createState() => new _CZBooksBookListPageBody(url);
}
class _CZBooksBookListPageBody extends State<CZBooksBookListPageBody>
{
  bool state = false;
  String url;
  List<Novel> novels;
  CZBookNovelListCrawler crawler;
  _CZBooksBookListPageBody(String url){this.url=url;}
  Future getDataAsync() async { 
    crawler = new CZBookNovelListCrawler();
    setState(() async{
      novels = await crawler.StartCrawlerAsync(url);
      print('set state');
    });
  } 
  ListView getBody()
  {
    print('get body success');
    sleep(Duration(seconds:1));
    List<Widget> widgets = new List<Widget>();
    novels.forEach((novel) {
      widgets.add (
        new Container(
        padding: EdgeInsets.all(5),
        child: new Column(children: [
          MyControls.commonText('Name: '+novel.name.trim()),
          MyControls.commonText('Author: '+novel.author),
          MyControls.commonText('Last Update: '+novel.lastUpdateDate.toString()),
          new ElevatedButton(onPressed: ()=>{MyRoute.routeChapterList(novel.name.trim(), novel.chapterList.url, context)}, child: MyControls.commonText('Go To Chapter List')),
          SizedBox(height: 10)
        ],)
        )
      );
     });
     return new ListView(children: widgets);
  }
  @override
  Widget build(BuildContext context) {
    getDataAsync();
    print('get body ?');
    if(novels?.isEmpty ?? true)
    {
      print('get body fail');
      setState(() {
        state=!state;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
      return MyControls.loadingWidget();
    }
    return getBody();
  }
  
}
class CZBooksBookListPage extends StatelessWidget
{
  String title;
  String url;
  List<Novel> novels;
  CZBookNovelListCrawler crawler;
  CZBooksBookListPage(String sortName,String url)
  {
    this.title=sortName;
    this.url=url;
  }
  @override
  Widget build(BuildContext context) {
    CZBooksBookListPageBody body = new CZBooksBookListPageBody(url);
    return new Scaffold(
      appBar: MyControls.commonAppBar(title, ()=>{}),
      body: body,
      );
  }
  
}