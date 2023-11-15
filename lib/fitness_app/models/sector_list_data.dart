class SectorListData {
  SectorListData({this.imagePath = '', this.titleTxt = '', this.num = 0});

  String imagePath;
  String titleTxt;
  int num;

  static List<SectorListData> sectorList = <SectorListData>[
    SectorListData(
      imagePath: 'a',
      titleTxt: 'Sector A',
      num: 1,
    ),
    SectorListData(
      imagePath: 'b',
      titleTxt: 'Sector B',
      num: 2,
    ),
    SectorListData(
      imagePath: 'c',
      titleTxt: 'Sector C',
      num: 3,
    ),
    SectorListData(
      imagePath: 'd',
      titleTxt: 'Sector D',
      num: 4,
    ),
    SectorListData(
      imagePath: 'e',
      titleTxt: 'Sector E',
      num: 5,
    ),
  ];
}
