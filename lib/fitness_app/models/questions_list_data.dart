class questionsListData {
  questionsListData({
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

  static List<questionsListData> tabIconsList = <questionsListData>[
    questionsListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      kacl: 0,
      name: '파랑 1',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      kacl: 0,
      name: '파랑 2',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      kacl: 0,
      name: '빨강 1',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 0,
      name: '빨강 2',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 0,
      name: '보라 1',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 0,
      name: '보라 2',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 0,
      name: '회색 1',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 0,
      name: '회색 2',
      startColor: '#33CC33',
      endColor: '#33CC33',
    ),
  ];
}
