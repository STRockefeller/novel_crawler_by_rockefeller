import 'package:flutter/material.dart';
import 'package:novel_crawler_by_rockefeller/MyControls.dart';
import 'package:novel_crawler_by_rockefeller/MyRoute.dart';

class Site
{
  Site(String siteName,String url)
  {
    this.siteName=siteName;
    this.url=url;
  }
  String siteName;
  String url;
  BuildContext context;
  void _link()=>MyRoute.routeUrl(url, context);
  ElevatedButton generateLinkButton(BuildContext context) 
  {
    this.context = context;
    return MyControls.siteListElevatedButton(_link, siteName);
  }
}
class SiteList
{
  static List<Site> list = <Site>[];
  static void addSite(String siteName,String url){list.add(new Site(siteName,url));}
  static Column generateWidget(BuildContext context)
  {
    List<ElevatedButton> linkList = [];
    list.forEach((site) {linkList.add(site.generateLinkButton(context));});
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: linkList,
    );
  }
  static void reset() =>list = <Site>[];
}