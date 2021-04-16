import 'package:flutter/material.dart';
import 'package:novel_crawler_by_rockefeller/View/CZBooksBookListPage.dart';
import 'package:novel_crawler_by_rockefeller/View/CZBooksHomePage.dart';
import 'package:novel_crawler_by_rockefeller/View/NovelReadPage.dart';

import 'View/ChapterListPage.dart';

class MyRoute
{
  static void routeUrl(String url,BuildContext context)
  {
    switch(url){
      case "czbooks.net":
        if(context!=null)
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CZBooksHomePage()));
        break;
        
      default:
        break;
    }
  }
  static void routeSort(String sortName,String url,BuildContext context)
  {
    if(context!=null)
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CZBooksBookListPage(sortName,url)));
  }
  static void routeChapterList(String novelName,String url,BuildContext context)
  {
    if(context != null)
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChapterListPage(novelName,url)));
  }
  static void routeArticle(String chapterName,String url,BuildContext context)
  {
    if(context != null)
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NovelReadPage(chapterName,url)));
  }
}