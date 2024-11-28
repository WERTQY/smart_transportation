class OrderDetails {
  String? orderId;
  String? name;
  String? phone;
  int? amount;
  String? pickup;
  String? destination;
  String? time;
  int? number;
  TimeOfOrderDay? timeOfDay;
  bool? hasCarPool;
  bool? confirmOrder;
  bool? canConfirmOrder;
  OrderLocation? pickupLocation;
  OrderLocation? destinationLocation;
  OrderLocation? passengerLocation;
  OrderLocation? driverLocation;

  OrderDetails(
      {this.orderId,
      this.name,
      this.phone,
      this.amount,
      this.pickup,
      this.destination,
      this.time,
      this.number,
      this.timeOfDay,
      this.hasCarPool,
      this.confirmOrder,
      this.canConfirmOrder,
      this.pickupLocation,
      this.destinationLocation,
      this.passengerLocation,
      this.driverLocation});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    name = json['name'];
    phone = json['phone'];
    amount = json['amount'];
    pickup = json['pickup'];
    destination = json['destination'];
    time = json['time'];
    number = json['number'];
    timeOfDay = json['timeOfDay'] != null
        ? new TimeOfOrderDay.fromJson(json['timeOfDay'])
        : null;
    hasCarPool = json['hasCarPool'];
    confirmOrder = json['confirmOrder'];
    canConfirmOrder = json['canConfirmOrder'];
    pickupLocation = json['pickupLocation'] != null
        ? new OrderLocation.fromJson(json['pickupLocation'])
        : null;
    destinationLocation = json['destinationLocation'] != null
        ? new OrderLocation.fromJson(json['destinationLocation'])
        : null;
    passengerLocation = json['passengerLocation'] != null
        ? new OrderLocation.fromJson(json['passengerLocation'])
        : null;
    driverLocation = json['driverLocation'] != null
        ? new OrderLocation.fromJson(json['driverLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['amount'] = this.amount;
    data['pickup'] = this.pickup;
    data['destination'] = this.destination;
    data['time'] = this.time;
    data['number'] = this.number;
    if (this.timeOfDay != null) {
      data['timeOfDay'] = this.timeOfDay!.toJson();
    }
    data['hasCarPool'] = this.hasCarPool;
    data['confirmOrder'] = this.confirmOrder;
    data['canConfirmOrder'] = this.canConfirmOrder;
    if (this.pickupLocation != null) {
      data['pickupLocation'] = this.pickupLocation!.toJson();
    }
    if (this.destinationLocation != null) {
      data['destinationLocation'] = this.destinationLocation!.toJson();
    }
    if (this.passengerLocation != null) {
      data['passengerLocation'] = this.passengerLocation!.toJson();
    }
    if (this.driverLocation != null) {
      data['driverLocation'] = this.driverLocation!.toJson();
    }
    return data;
  }
}

class TimeOfOrderDay {
  int? hour;
  int? minute;

  TimeOfOrderDay({this.hour, this.minute});

  TimeOfOrderDay.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    return data;
  }
}

class OrderLocation {
  double? lat;
  double? lng;

  OrderLocation({this.lat, this.lng});

  OrderLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}