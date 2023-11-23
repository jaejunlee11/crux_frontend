class ToolsListData {
  ToolsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.tools,
    this.kacl = '',
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? tools;
  String kacl;

  static List<ToolsListData> tabIconsList = <ToolsListData>[
    ToolsListData(
      imagePath: 'assets/fitness_app/tab_2.png',
      titleTxt: '클라이밍화',
      kacl: "http://www.jrsports.net/product/?cate_mode=list&lcate=212",
      tools: <String>['클라이밍화,', 'Peanut butter,', 'Apple'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    ToolsListData(
      imagePath: 'assets/fitness_app/bag.png',
      titleTxt: '클라이밍\n초크',
      kacl: "http://www.jrsports.net/product/?cate_mode=list&lcate=372",
      tools: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    ToolsListData(
      imagePath: 'assets/fitness_app/tape.png',
      titleTxt: '클라이밍\n테이프',
      kacl:
          "http://www.jrsports.net/product/?cate_mode=view&no=11996&lcate=373&schKeyword=&reSearchKeyword=",
      tools: <String>['Recommend:', '800 kcal'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    ToolsListData(
      imagePath: 'assets/fitness_app/pouder.png',
      titleTxt: '발냄새\n제거제',
      kacl:
          "https://www.oliveyoung.co.kr/store/goods/getGoodsDetail.do?goodsNo=A000000173811&t_page=%ED%86%B5%ED%95%A9%EA%B2%80%EC%83%89%EA%B2%B0%EA%B3%BC%ED%8E%98%EC%9D%B4%EC%A7%80&t_click=%EC%83%81%ED%92%88%EC%83%81%EC%84%B8&t_search_name=%EA%B7%B8%EB%9E%9C%EC%A6%88%EB%A0%88%EB%AF%B8%EB%94%94%20%EC%98%A4%EB%A6%AC%EC%A7%80%EB%84%90&t_number=1&dispCatNo=1000002000500050004&trackingCd=Result_1",
      tools: <String>['Recommend:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
