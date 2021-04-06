class AddNewFriendRequest{
  int  sender_user_id = 0 ;
  int receiver_user_id = 0 ;

  AddNewFriendRequest(this.sender_user_id, this.receiver_user_id);

  @override
  String toString() {
    return 'AddNewFriendRequest{sender_user_id: $sender_user_id, receiver_user_id: $receiver_user_id}';
  }

  Map toJson() => {
    "sender_user_id": sender_user_id,
    "receiver_user_id": receiver_user_id
  };
}