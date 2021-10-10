class BookingTimeModel{
  late String userId;
  late int from;
  late int to;
  late int fees;
  late bool isBooked;
  late bool isDone;
  late String userName;
  late String userPhone;
  late String randomNumber;
  late bool isDeposit;
  late bool depositPaid;
  late String bookingDate;
  late int pay;


  BookingTimeModel({
    required this.userId,
    required this.from,
    required this.to,
    required this.fees,
    required this.isBooked,
    required this.isDone,
    required this.userName,
    required this.userPhone,
    required this.randomNumber,
    required this.isDeposit,
    required this.bookingDate,
    required this.depositPaid,
    required this.pay
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
      "userPhone":userPhone,
      "randomNumber":randomNumber,
      "isDeposit":isDeposit,
      "bookingDate":bookingDate,
      "depositPaid":depositPaid,
      "pay":pay
    };
  }
}