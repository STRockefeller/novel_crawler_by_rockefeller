
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_crawler_by_rockefeller/MyControls.dart';
import 'package:novel_crawler_by_rockefeller/MyRoute.dart';
import 'package:novel_crawler_by_rockefeller/Novel.dart';

import '../INovelCrawler.dart';

class ChapterListBody extends StatefulWidget
{
  String url;
  ChapterListBody(String url){this.url=url;}
  @override
  State<StatefulWidget> createState() => new _ChapterListBody(url);
}
class _ChapterListBody extends State<ChapterListBody>
{
  String url;
  List<Article> articles = new List<Article>();
  CZBookNovelChapterCrawler crawler; 
  _ChapterListBody(String url){this.url=url;}
  Future getDataAsync() async { 
    crawler = new CZBookNovelChapterCrawler();
    setState(() async{
      articles = await crawler.StartCrawlerAsync(url);
      print('set state');
    });
  }
  ListView getBody(){
    sleep(Duration(seconds:1));
    List<Widget> widgets = new List<Widget>();
    articles.forEach((article) {
      widgets.add(new ElevatedButton(onPressed: (){MyRoute.routeArticle(article.chapterName, article.url, context);},child: MyControls.commonText(article.chapterName),));
     });
    ListView res = new ListView(children: widgets);
    return res;
  }
  @override
  Widget build(BuildContext context) {
    getDataAsync();
    if(articles?.isEmpty??true)
    {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
      return MyControls.loadingWidget();
    }
    return getBody();
  }
  
}
class ChapterListPage extends StatelessWidget
{
  String title;
  String url;
  ChapterListBody body;
  ChapterListPage(String title,String url)
  {
    this.title=title;
    this.url = url;
  }
  @override
  Widget build(BuildContext context) {
    body = new ChapterListBody(url);
    return new Scaffold(
      appBar: MyControls.commonAppBar(title, ()=>{}),
      body: body,
      );
  }
}