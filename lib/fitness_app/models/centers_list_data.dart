class centersListData {
  centersListData(
      {this.name = '',
      this.startColor = '',
      this.endColor = '',
      this.sectorNum = 0});

  String startColor;
  String endColor;
  String name;
  int sectorNum;

  factory centersListData.fromJson(Map<String, dynamic> json) {
    return centersListData(
      name: json['spotname'],
      startColor: '#33CC33',
      endColor: '#33CC33',
      sectorNum: json['spotid'],
    );
  }

  dynamic toJson() => {
        'spotname': name,
        'spotid': sectorNum,
      };
}
