class centersListData {
  centersListData({
    this.imagePath = '',
    this.name = '',
    this.startColor = '',
    this.endColor = '',
    this.kacl = 0,
  });

  String imagePath;
  String startColor;
  String endColor;
  String name;
  int kacl;

  static List<centersListData> tabIconsList = <centersListData>[
    centersListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      kacl: 0,
      name: '볼더프랜즈',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    centersListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      kacl: 0,
      name: '볼더메이트',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    centersListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      kacl: 0,
      name: '더클라임신림',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    centersListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 0,
      name: '더클라임강남',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
  ];
}
