class UserBalance {
  double? totalBalance;
  double? availableBalance;
  double? holdBalance;

  UserBalance({this.totalBalance, this.availableBalance, this.holdBalance});

  UserBalance.fromJson(Map<String, dynamic> json) {
    totalBalance = json['TotalBalance'];
    availableBalance = json['AvailableBalance'];
    holdBalance = json['HoldBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalBalance'] = this.totalBalance;
    data['AvailableBalance'] = this.availableBalance;
    data['HoldBalance'] = this.holdBalance;
    return data;
  }
}