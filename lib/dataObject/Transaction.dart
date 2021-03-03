class Transaction {
  DateTime dateTime;
  int amount = 0;

  Transaction({int amount, DateTime dateTime}) {
    this.amount = amount;
    if (dateTime != null) {
      this.dateTime = dateTime;
    } else {
      DateTime currentDate = DateTime.now();
      currentDate.subtract(Duration(days: 5));
      this.dateTime = currentDate;
    }
  }
}
