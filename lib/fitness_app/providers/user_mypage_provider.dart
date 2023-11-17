import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  String MYURL = '61.98.244.12:8000';
  User? _user;
  bool _isLoading = false;
  String _error = '';

  User? get user => _user;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<User?> fetchUserInfo(String userId) async {
    _isLoading = true;
    _error = 'failed to get user info'; // Reset error message

    final url = 'http://$MYURL/user/$userId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dynamic responseData =
            jsonDecode(utf8.decode(response.bodyBytes));

        if (responseData is List<dynamic> && responseData.isNotEmpty) {
          // If the response is a non-empty JSON array, take the first element
          final Map<String, dynamic> userData = responseData[0];
          print("Fetched user data(array): $userData");
          _user = User.fromJson(userData);
          print("convert complete: ${_user?.profilepic}");
          notifyListeners();
          return _user;
        } else if (responseData is Map<String, dynamic>) {
          // If the response is a JSON object
          print("Fetched user data(object): $responseData");
          _user = User.fromJson(responseData);
          notifyListeners();
          return _user;
        } else {
          _error = 'Received unexpected response format.';
          print(_error);
          return null;
        }
      } else {
        _error =
            'Failed to fetch user information. Status code: ${response.statusCode}';
        print(_error);
        return null;
      }
    } catch (e) {
      _error = 'Error fetching user information: $e';
      print(_error);
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfilePic(User user, String newProfilePic) async {
    final updatedUser = user.copyWith(profilepic: newProfilePic);
    notifyListeners();

    // Update the profile picture in the database
    final response = await http.put(
      Uri.parse("http://$MYURL/put-user/${updatedUser.ID}"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedUser
          .toJson()), // assuming toJson() method is implemented in the User class
    );

    if (response.statusCode != 200) {
      // Handle errors when updating profile picture in the database
      print(
          'Failed to update profile picture. Status code: ${response.statusCode}');
      throw Exception(
          'Failed to update profile picture. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateIntro(String userId, String newIntro) async {
    final url = 'http://$MYURL/put-user/$userId';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'memberid': userId, 'memberprofileintro': newIntro}),
      );

      if (response.statusCode == 200) {
        // Successfully updated intro in the database
      } else {
        print('Failed to update intro. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating intro: $e');
    }
  }
}
