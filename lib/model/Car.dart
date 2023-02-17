class Car {
  String id;
  String make;
  String model;
  int engineSize;
  int horsePower;

  Car(this.id, this.make, this.model, this.engineSize, this.horsePower);

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        json['id'],
        json['make'],
        json['model'],
        json['engineSize'],
        json['horsePower']
    );
  }
}