class CarDetails {
  String id;
  String make;
  String model;
  String color;
  int engineSize;
  int horsePower;
  String photoUrl;
  bool isUserFavourite;
  bool isUserOwner;

  CarDetails(this.id, this.make, this.model, this.color, this.engineSize,
      this.horsePower, this.photoUrl, this.isUserFavourite, this.isUserOwner);

  factory CarDetails.fromJson(Map<String, dynamic> json) {
    return CarDetails(
        json['id'],
        json['make'],
        json['model'],
        json['color'],
        json['engineSize'],
        json['horsePower'],
        json['photoUrl'],
        json['isUserFavourite'],
        json['isUserOwner']);
  }
}