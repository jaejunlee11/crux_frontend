class SectorListData {
  SectorListData({
    this.imagePath = '',
    this.titleTxt = '',
  });

  String imagePath;
  String titleTxt;

  static List<SectorListData> sectorList = <SectorListData>[
    SectorListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      titleTxt: 'Sector A',
    ),
    SectorListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      titleTxt: 'Sector B',
    ),
    SectorListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      titleTxt: 'Sector C',
    ),
    SectorListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      titleTxt: 'Sector D',
    ),
    SectorListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      titleTxt: 'Sector E',
    ),
  ];
}
