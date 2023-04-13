class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.startColor = '',
    this.endColor = '',
    this.kacl = 0,
  });

  String imagePath;
  String startColor;
  String endColor;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      kacl: 1,
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      kacl: 1,
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      kacl: 1,
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      kacl: 0,
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
