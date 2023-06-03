import 'dart:convert';
import 'package:best_flutter_ui_templates/fitness_app/models/centers_list_data.dart';
import 'package:http/http.dart' as http;

class CenterProvider {
  static Future<List<centersListData>> fetchCenterListData() async {
    // String urlString = "http://3.39.160.193:8000/spotname";
    String urlString = "http://0.0.0.0:8000/spotname";
    Uri uri = Uri.parse(urlString);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<centersListData> listData = responseData
          .map((dynamic item) => centersListData.fromJson(item))
          .toList();
      return listData;
    } else {
      print("오류");
      return <centersListData>[];
    }
  }
}
