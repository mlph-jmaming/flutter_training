class Transaction {
  DateTime dateTime;
  int amount = 0;
  String description = "";
  bool isSent = false;

  Transaction({int amount, DateTime dateTime, String description}) {
    this.amount = amount;
    if (dateTime != null) {
      this.dateTime = dateTime;
      if (description != null) this.description = description;
    } else {
      DateTime currentDate = DateTime.now();
      currentDate.subtract(Duration(days: 5));
      this.dateTime = currentDate;
      if (description != null) this.description = description;
    }
  }
}
