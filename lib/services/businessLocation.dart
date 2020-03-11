class BusinessLocation {
  final String address;

  BusinessLocation({this.address});

  factory BusinessLocation.fromJson(Map<String, dynamic> json) {
    var addressString = "";
    var locationArray = (json['display_address']).cast<String>();
    for (var line in locationArray) {
      if (addressString != "") {
        addressString += " ";
      }
      addressString += line;
    }
    return BusinessLocation(
      address: addressString,
    );
  }
}
