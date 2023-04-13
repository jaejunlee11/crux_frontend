class SectorListData {
  SectorListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.rating = 4.5,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double rating;

  static List<SectorListData> sectorList = <SectorListData>[
    SectorListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      titleTxt: 'Sector A',
      subTxt: '난이도: 빨강',
      rating: 5,
    ),
    SectorListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      titleTxt: 'Sector B',
      subTxt: '난이도: 파랑',
      rating: 4,
    ),
    SectorListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      titleTxt: 'Sector C',
      subTxt: '난이도: 보라',
      rating: 6,
    ),
    SectorListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      titleTxt: 'Sector D',
      subTxt: '난이도: 회색',
      rating: 7,
    ),
    SectorListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      titleTxt: 'Sector E',
      subTxt: '난이도: 초록',
      rating: 3,
    ),
  ];
}
