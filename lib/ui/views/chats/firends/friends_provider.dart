
import 'package:flutter/foundation.dart';
import 'package:phinex/Bles/Model/responses/social/UserProfileResponse.dart';

class FriendsProvider with ChangeNotifier {

  List<UserSocial> _selectedFriends = [];

  List<UserSocial> get selectedFriends => _selectedFriends;

  void addFriend(UserSocial userSocial) {
    _selectedFriends.add(userSocial);
    notifyListeners();
  }

  void removeFriend(int index) {
    _selectedFriends.removeAt(index);
    notifyListeners();
  }
}