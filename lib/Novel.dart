
class Novel
{
  String name;
  String author;
  DateTime lastUpdateDate;
  ChapterList chapterList;

  Novel(String name,String author,DateTime lastUpdateDate,[ChapterList chapterList])
  {
    this.name=name;
    this.author=author;
    this.lastUpdateDate=lastUpdateDate;
    if(chapterList != null)
      this.chapterList = chapterList;
  }
}
class ChapterList
{
  String novelName;
  String url;
  List<Article> articles;
  ChapterList(String novelName,String url,[List<Article> articles])
  {
    this.novelName=novelName;
    this.url=url;
    if(articles != null)
      this.articles = articles;
  }
}
class Article
{
  String chapterName;
  String url;
  String content;
  Article(String chapterName,String url,[String content])
  {
    this.chapterName=chapterName;
    this.url=url;
    if(!(content?.isEmpty??true))
      this.content=content;
  }
  void getContent()
  {
    //todo
  }
}