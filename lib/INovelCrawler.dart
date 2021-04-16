import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:novel_crawler_by_rockefeller/Novel.dart';

abstract class INovelChapterCrawler
{
  Future<List<Article>> StartCrawlerAsync(String url);
}

abstract class INovelListCrawler
{
  Future<List<Novel>> StartCrawlerAsync(String url);
}

class CZBookNovelListCrawler extends INovelListCrawler
{
  @override
  Future<List<Novel>> StartCrawlerAsync(String url) async
  {
    print('Enter Scrawler Method');
    DateTime getDate(dom.Element e)
    {
      List<String> ls = e.text.split("-");
      return new DateTime(int.parse(ls[0]),int.parse(ls[1]),int.parse(ls[2]));
    }
    //"//czbooks.net/n/uiimbp"
    var urls = url.split('/');
    http.Response response = await http.get(Uri.https(urls[2], '/'+urls[3]+'/'+urls[4]));
    print(response.toString());
    //http.Response response = await http.get(Uri.https(url,''));
    dom.Document doc = parser.parse(response.body);
    List<Novel> novels = new List<Novel>();
    List<dom.Element> novelElements = doc.getElementsByClassName('novel-item-wrapper');
    novelElements.forEach((element) {
      novels.add(new Novel(element.getElementsByClassName('novel-item-title').first.text,
      element.getElementsByClassName('novel-item-author').first.getElementsByTagName('a').first.text,
      element.getElementsByClassName('novel-item-date').map((e)=>getDate(e)).first,
      new ChapterList(element.getElementsByClassName('novel-item-title').first.text,
      element.getElementsByClassName('novel-item-cover-wrapper').first.getElementsByTagName('a').first.attributes['href']))
      );
    });
    print('return novels');
    return novels;
  }
  
}
class CZBookNovelChapterCrawler extends INovelChapterCrawler
{
  @override
  Future<List<Article>> StartCrawlerAsync(String url) async{
    List<Article> res = new List<Article>();
    //url like "//czbooks.net/n/uiadcg"
    var urls = url.split('/');
    http.Response response = await http.get(Uri.https(urls[2], '/'+urls[3]+'/'+urls[4]));
    dom.Document doc = parser.parse(response.body);
    List<dom.Element> chapterElements = doc.getElementsByClassName("nav chapter-list").first.getElementsByTagName("a");
    chapterElements.forEach((element) {
      res.add(new Article(element.text,element.attributes['href']));
     });
     print('Chapter List Crawl Completion');
    return res;
  }
}
class CZBookNovelArticleCrawler
{
  Future<String> startCrawlerAsync(String url) async{
    var urls = url.split('/');
    http.Response response = await http.get(Uri.https(urls[2], '/'+urls[3]+'/'+urls[4]+'/'+urls[5]));
    dom.Document doc = parser.parse(response.body);
    String res ="";
    res = doc.getElementsByClassName('content').first.text;
    return res;
  }
}
