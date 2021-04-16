
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novel_crawler_by_rockefeller/INovelCrawler.dart';
import 'package:novel_crawler_by_rockefeller/MyControls.dart';




class NovelReadPageBody extends StatefulWidget
{
  String url;
  NovelReadPageBody(String url){this.url=url;}
  @override
  State<StatefulWidget> createState() => new _NovelReadPageBody(url);
}
class _NovelReadPageBody extends State<NovelReadPageBody>
{
  String url;
  String article;
  _NovelReadPageBody(String url){this.url=url;}
  Widget getBody()=>new Container(child: MyControls.commonText(article));
  void getDataAsync() async{
    CZBookNovelArticleCrawler crawler = new CZBookNovelArticleCrawler();
    setState(() async{
      article = await crawler.startCrawlerAsync(url);
    });
  }
  @override
  Widget build(BuildContext context) {
    getDataAsync();
    if(article?.isEmpty??true)
    {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
      return MyControls.loadingWidget();
    }
    return getBody();
  }
  
}
class NovelReadPage extends StatelessWidget
{
  String chapterName;
  String url;
  NovelReadPage(String chapterName,String url)
  {
    this.chapterName = chapterName;
    this.url=url;
  }
  @override
  Widget build(BuildContext context) {
    Widget body = new NovelReadPageBody(url);
    return new Scaffold(
      appBar: MyControls.commonAppBar(chapterName, (){}),
      body: body,
    );
  }
}