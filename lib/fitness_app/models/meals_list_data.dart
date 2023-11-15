class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.startColor = '',
    this.endColor = '',
    this.sectornum = 0,
  });

  String imagePath;
  String startColor;
  String endColor;
  int sectornum;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/plus.png',
      sectornum: 0,
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/plus.png',
      sectornum: 1,
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/plus.png',
      sectornum: 2,
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/plus.png',
      sectornum: 3,
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
