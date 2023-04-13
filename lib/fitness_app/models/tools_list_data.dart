class ToolsListData {
  ToolsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.tools,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? tools;
  int kacl;

  static List<ToolsListData> tabIconsList = <ToolsListData>[
    ToolsListData(
      imagePath: 'assets/fitness_app/tab_2.png',
      titleTxt: '클라이밍화',
      kacl: 525,
      tools: <String>['클라이밍화,', 'Peanut butter,', 'Apple'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    ToolsListData(
      imagePath: 'assets/fitness_app/bag.png',
      titleTxt: '클라이밍\n초크',
      kacl: 602,
      tools: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    ToolsListData(
      imagePath: 'assets/fitness_app/tape.png',
      titleTxt: '클라이밍\n테이프',
      kacl: 0,
      tools: <String>['Recommend:', '800 kcal'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    ToolsListData(
      imagePath: 'assets/fitness_app/pouder.png',
      titleTxt: '발냄새\n제거제',
      kacl: 0,
      tools: <String>['Recommend:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
