class BookingTimeModel{
  late String userId;
  late int from;
  late int to;
  late int fees;
  late bool isBooked;
  late bool isDone;
  late String userName;
  late String userPhone;

  BookingTimeModel({
    required this.userId,
    required this.from,
    required this.to,
    required this.fees,
    required this.isBooked,
    required this.isDone,
    required this.userName,
    required this.userPhone
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "from": from,
      "to": to,
      "fees": fees,
      "isBooked": isBooked,
      "isDone": isDone,
      "userName": userName,
      "userPhone":userPhone
    };
  }
}