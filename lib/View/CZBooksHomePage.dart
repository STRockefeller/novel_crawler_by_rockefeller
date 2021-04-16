
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novel_crawler_by_rockefeller/MyControls.dart';
//import 'package:web_scraper/web_scraper.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class CZBooksHomePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new _CZBooksHomePageState();
}
class _CZBooksHomePageState extends State<CZBooksHomePage>
{
  List<Map<String,String>> novelSort;

  Future<dom.Document> getData() async { 
  Uri url =Uri.https('czbooks.net', '');
  //http.Response response = await http.get('https://czbooks.net/');
  http.Response response = await http.get(url);
  return parser.parse(response.body);
  } 

  void fetchProducts() async {
    dom.Document document = await getData();
    if(document != null && this.mounted)
    {
      setState(() {
        var ns = document.getElementsByClassName('nav menu').first.getElementsByTagName('a').map((d)=>{d.text:d.attributes['href']});
        novelSort = List.from(ns);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    fetchProducts(); //不用await不知道行不行
    if(novelSort?.isEmpty??true)
    {
      return new Scaffold(
        appBar: MyControls.commonAppBar("CZBooks", ()=>{}),
        body: MyControls.loadingWidget(),
      );
    }
    return new Scaffold(
      appBar: MyControls.commonAppBar("CZBooks", ()=>{}),
      drawer: MyControls.novelSortDrawer(novelSort, context),
    );
  }
}