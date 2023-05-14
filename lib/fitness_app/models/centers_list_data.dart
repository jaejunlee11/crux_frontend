class centersListData {
  centersListData({
    this.name = '',
    this.startColor = '',
    this.endColor = '',
  });

  String startColor;
  String endColor;
  String name;

  factory centersListData.fromJason(Map<String, dynamic> json) {
    return centersListData(
      name: json['spotname'],
      startColor: '#33CC33',
      endColor: '#33CC33',
    );
  }

  dynamic toJason() => {
        'spotname': name,
      };
}
